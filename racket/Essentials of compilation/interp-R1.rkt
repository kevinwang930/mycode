#lang racket
(require racket/fixnum)
(provide interp-R1 interp-C0)
;  exp::= int|(read)|(- exp)|(+ exp exp)
;       | var|(let ([var exp]) exp)
;  R1 ::= (program exp)
(define (lookup e env)
  (cond [(null? env) (error 'lookup "does not find value of " e)]
        [else (if (eq? e (car (car env)))
                  (cadr (car env))
                  (lookup e (cdr env)))]))
(define (interp-exp env)
  (lambda (e)
    (define recur (interp-exp env))
    (match e
      [(? symbol?) (lookup e env)]
      [(list 'let (list [list x exp]) body)
       (define new-env (cons (list x (recur exp)) env))
       ((interp-exp new-env) body)]
      [(? fixnum?) e]
      ['(read)
       (define r (read))
       (cond [(fixnum? r) r]
             [else (error 'interp-exp "expected an integer but actually ~a" r)])]
      [(list '- r1) (fx- 0 (recur r1))]
      [(list '+ r1 r2) (fx+ (recur r1) (recur r2))])))


(define (interp-R1 e)
  (match e
    [(list 'program exp) ((interp-exp '()) exp)]))

(define (interp-C0-stmt env)
  (lambda (s)
    (match s
      [(list 'assign x e)
       (cons (list x ((interp-exp env) e))
             env)])))

(define (interp-C0-tail env)
  (lambda (t)
    (match t
      [`((return ,e) . ,t) ((interp-exp env) e)]
      [`(,s . ,t2)
       (define new-env ((interp-C0-stmt env) s))
       ((interp-C0-tail new-env) t2)])))

(define (interp-C0 e)
  (match e
    [`(program ,v . ,t) ((interp-C0-tail `()) t)]))

;(define p '(program (+ (read) (+ (let ((v (+ 2 (let ((x 6)) x)))) (+ (let ((v 2)) v) v)) (+ 2 (read))))))
;(define q '(program () 42))
;(with-input-from-file "tests/r1_4.in" (lambda () (interp-R1 p)))
;(interp-C0 q)