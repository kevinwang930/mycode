
#lang eopl
;parse-expression: Scheme Val -> LcExp
#| Lc-exp ::= Identifier
          var-exp (var)
          ::= (lambda ({Identifier}*) Lc-exp)
          lambda-exp (bound-var body)
          ::= (Lc-exp Lc-exp)
          app-exp (rator rand)    |#

(define-datatype lc-exp lc-exp?
  (var-exp (var symbol?))
  (lambda-exp (bound-vars (list-of symbol?))
              (body lc-exp?))
  (app-exp (rator lc-exp?)
           (rand lc-exp?)))
(define parse-expression
  (lambda (datum)
    (cond
      ((symbol? datum) (if (identifier? datum)
                           (var-exp datum)
                           (eopl:error "An Identifier" datum)))
      ((pair? datum) (if (eq? 'lambda (car datum))
                         (parse-lambda-expression datum)
                         (parse-application-expression datum)))
      (else (report-error "a symbol or pair" datum)))))
(define parse-lambda-expression
  (lambda (datum)
    (let ((After-lambda (cdr datum)))
          (if (null? datum)
              (report-error "bound vars and lc-exp after lambda" datum)
              (let ((Bound-vars (car After-lambda))
                    (After-bound-vars (cdr After-lambda)))
                (if (null? Bound-vars)
                    (report-error "bound vars after lambda" Bound-vars)
                    (if (pair? Bound-vars)
                        (if ((list-of identifier?) Bound-vars)
                            (if (null? After-bound-vars)
                                (report-error "body after bound var" After-bound-vars)
                                (let ((body (car After-bound-vars))
                                      (After-body (cdr After-bound-vars)))
                                  (if (null? After-body)
                                      (lambda-exp Bound-vars (parse-expression body))
                                      (report-error "null after body" After-body))))
                            (report-error "bound vars as identifier" Bound-vars))
                        (report-error "bound vars with parenthsis after lambda" Bound-vars))))))))
(define parse-application-expression
  (lambda (datum)
    (if (null? datum)
        (report-error "application expression" datum)
        (if (null? (cdr datum))
            (report-error "valid operand" datum)
            (let ((rator (car datum))
                  (rand (cadr datum))
                  (after-rand (cddr datum)))
              (if (null? after-rand)
                  (app-exp (parse-expression rator)
                           (parse-expression rand))
                  (report-error "2 lc expression" datum)))))))
(define identifier?
  (lambda (var)
    (cond
      ((eq? var 'lambda) #f)
      (else (symbol? var)))))
(define report-invalid-concrete-syntax
  (lambda (datum)
    (eopl:error 'parse-expression "concrete syntax invalid")))
(define report-error
  (lambda (expected datum)
    (eopl:error 'parse-expression "Expected ~a, but got ~s" expected datum)))
(parse-expression '(lambda (x y) (x y)))

