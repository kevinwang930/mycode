 #lang racket
(require racket/fixnum
         "utilities.rkt")
(provide interp-R0)
; bnf normal forms RO integer
; exp::= int
; exp::= (read)
; exp::= (- exp)
; exp::= (+ exp exp)
; exp::= (program exp)
; exp::= int|(read)|(- exp)|(+ exp exp)
; R0 ::= (program exp)

(define (leaf? arith)
  (match arith
    [(? fixnum?) #t]
    [`(read) #t]
    [`(- ,C1) #f]
    [`(+ ,C1 ,C2) #f]))
;(leaf? `(read))
;(leaf? `(+ (read) (- 8)))

(define (R0? sexp)
  (define (exp? ex)
    (match ex
      [(? fixnum?) #t]
      ['(read) #t]
      [(list '- e) (exp? e)]
      [(list '+ e1 e2) (and (exp? e1) (exp? e2))]
      [else #f]))
  (match sexp
    [(list 'program e) (exp? e)]
    [else #f]))
;(R0? `(program (+ (read) (- 8))))
;(R0? '(program (- (read) (+ 8))))

(define (interp-R0 p)
  (define (exp ex)
    (match ex
      [(? fixnum?) ex]
      ['(read) (let ((r (read)))
                 (cond
                   [(fixnum? r) r]
                   [else (error 'interp-R0 "input not an integer")]))]
      [(list '- e) (fx- 0 (exp e))]
      [(list '+ e1 e2) (fx+ (exp e1) (exp e2))]))
  (match p
    [(list 'program e) (exp e)]))


; partial evaluator
(define (pe-neg r)
  (cond [(fixnum? r) (fx- 0 r)]
        [else (list '- r)]))

(define (pe-add r1 r2)
  (cond [(and (fixnum? r1) (fixnum? r2)) (fx+ r1 r2)]
        [else (list '+ r1 r2)]))

(define (pe-arith e)
   (match e
    [(? fixnum?) e]
    ['(read) '(read)]
    [(list '- r) (pe-neg (pe-arith r))]
    [(list '+ r1 r2) (pe-add-new (pe-arith r1) (pe-arith r2))]))



;;; improve partial evaluator to produce simpler result
; exp     ::= (read)|(- (read))|(+ exp exp)
; residual::= int|(+ int exp)|exp

(define (pe-add-new r1 r2)
  (cond ((and (fixnum? r1) (fixnum? r2)) (fx+ r1 r2))
        [(fixnum? r1) (match r2
                        [(list '+ c1 c2)
                         #:when (fixnum? c1)
                         (list '+ (fx+ r1 c1) c2)]
                        [(list '+ c1 c2)
                         #:when (fixnum? c2)
                         (list '+ (fx+ r1 c2) c1)]
                        ['(read) (list '+ r1 '(read))])]
        [(fixnum? r2) (match r1
                        [(list '+ c1 c2)
                         #:when (fixnum? c1)
                         (list '+ (fx+ r2 c1) c2)]
                        [(list '+ c1 c2)
                         #:when (fixnum? c2)
                         (list '+ (fx+ r2 c2) c1)]
                        ['(read) (list '+ r2 '(read))])]
        (else (list '+ r1 r2))))



(define p '(program (+ (read) (+ 1 (+ 2 (read))))))
(define (test-pe p)
  (assert "testing pe-arith"
          (equal? (interp-R0 p) (interp-R0 (pe-arith p)))))
(pe-arith '(+ (+ (read) 10) 10))

(interp-tests "interp-R0" #f 1 1 1 1)







