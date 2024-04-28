#lang racket
; 2.16 Modify the implementation to use a representation in which there
;are no parentheses around the bound variable in a lambda expression

;Constructor

;var-exp:Var -> LcExp
(define var-exp
  (lambda (var)
    var))
;lambda-exp:Var*LcExp -> LcExp
(define lambda-exp
  (lambda (bound-var body)
    (list 'lambda
          bound-var
          body)))
;app-exp:LcExp*LcExp -> LcExp
(define app-exp
  (lambda (operator operand)
    (list operator operand)))

;Predicates

;var-exp? Lc-exp->Boolean
(define var-exp? symbol?)
;lambda-exp? Lc-exp -> Boolean
(define lambda-exp?
  (lambda (exp)
    (and (pair? exp)
         (eq? (car exp) 'lambda))))
;app-exp? Lc-exp -> Boolean
(define app-exp?
  (lambda (exp)
    (and (pair? exp)
         (not (eq? (car exp) 'lambda)))))

;Extractor
;var-exp->var:Lc-exp->Var
(define var-exp->var
  (lambda (exp)
    exp))
;lambda-exp->bound-var:Lc-exp->Bound-var
(define lambda-exp-bound-var
  (lambda (exp)
    (cadr exp)))
;lambda-exp->body:Lc-exp->Lc-exp
(define lambda-exp->body
  (lambda (exp)
    (caddr exp)))
(define app-exp->rator car)
(define app-exp->rand cadr)

