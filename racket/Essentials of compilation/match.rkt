#lang racket

;exp ::= int | (read) | (- exp) | (+ exp exp)
; R0 ::= (program exp)
(require racket/match)
(require racket/fixnum)
(require "utilities.rkt")
(define ast1.4 (list '- 8))
(define ast1.1 (list '+ (read) ast1.4))
(define (leaf? arith)
  (match arith
    [(? fixnum?) #t]
    [(list 'read) #t]
    [(list '- c1) #f]
    [(list '+ c1 c2) #f]))
;(leaf? '(read))
;(leaf? '(- 8))
;(leaf? '(+ (read) (- 8)))

(define (R0? sexp)
  (define (exp? ex)
    (match ex
      [(? fixnum?) #t]
      [(list 'read) #t]
      [(list '- op1) (exp? op1)]
      [(list '+ op1 op2) (and (exp? op1) (exp? op2))]
      [_ #f]))
  (match sexp
    [(list 'program e) (exp? e)]
    [_ #f]))

;(R0? '(program (+ (read) (- 8))))
;(R0? '(program (- (read) (+ 8))))
(define (interp-R0 p)
  (define (exp ex)
    (match ex
      [(? fixnum?) ex]
      [(list 'read) (let ((r (read)))
                      (cond
                        [(fixnum? r) r]
                        [else (error 'interp-R0 "input not an integer")]))]
      [(list '- op) (fx- 0 (exp op))]
      [(list '+ op1 op2) (fx+ (exp op1) (exp op2))]))
  (match p
    [(list 'program e) (exp e)]
    [e (interp-R0(list 'program e))]))
;(interp-R0 (list 'program ast1.1))

(define (pe-neg r)
  (cond
    [(fixnum? r) (fx- 0 r)]
    [else (list '- r)]))
(define (pe-add r1 r2)
  (cond
    [(and (fixnum? r1) (fixnum? r2)) (fx+ r1 r2)]
    [else (list '+ r1 r2)]))
(define (pe-arith e)
  (match e
    [(? fixnum?) e]
    [(list 'read) (list 'read)]
    [(list '- (app pe-arith r1)) (pe-neg r1)]
    [(list '+ (app pe-arith r1) (app pe-arith r2)) (pe-add r1 r2)]))
(define (test-pe p)
  (assert "testing pe-arith"
          (equal? (interp-R0 p) (interp-R0 (pe-arith p)))))

;(test-pe '(+ (read) (- (+ 5 3))))
;(pe-arith '(+ (read) (- (+ 5 3))))
;(test-pe '(+ 1 (+ (read) 1)))

;;;exp ::= (read) | (- (read)) | (+ exp exp)
;;;residual ::= int | (+ int exp) | exp

(define (pe-arith e)
  (match e
    [(? fixnum?) e]
    [(list 'read) (list 'read)]
    [(list '- (app pe-arith r1)) (pe-neg r1)]
    [(list '+ (app pe-arith r1) (app pe-arith r2)) (pe-add-new r1 r2)]))
(define (pe-neg r)
  (cond
    [(fixnum? r) (fx- 0 r)]
    [else (list '- r)]))
(define (pe-add-new r1 r2)
  (cond
    [(and (fixnum? r1) (fixnum? r2)) (fx+ r1 r2)]
    [(fixnum? r1) (match r2
                    [(list 'read) (list '+ r1 r2)]
                    [])]))




