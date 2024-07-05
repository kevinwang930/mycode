#lang eopl
;parse-expression: Scheme Val -> LcExp
#| Lc-exp ::= Identifier
   var-exp (var)
          ::= (lambda (Identifier) Lc-exp)
          lambda-exp (bound-var body)
          ::= (Lc-exp Lc-exp)
          app-exp (rator rand)    |#
(define-datatype lc-exp lc-exp?
  (var-exp (var symbol?))
  (lambda-exp (bound-var symbol?)
              (body lc-exp?))
  (app-exp (rator lc-exp?)
           (rand lc-exp?)))
(define parse-expression
  (lambda (datum)
    (cond
      ((symbol? datum) (var-exp datum))
      ((pair? datum)
       (if(eq? 'lambda (car datum))
          (lambda-exp (caadr datum) (parse-expression (caddr datum)))
          (app-exp (car datum) (cadr datum))))
      (else (report-invalid-concrete-syntax datum)))))
(define report-invalid-concrete-syntax
  (lambda (datum)
    (eopl:error 'parse-expression "concrete syntax invalid")))
;unparse-lc-exp: LcExp -> schemeVal
(define unparse-lc-exp
  (lambda (exp)
    (cases lc-exp exp
      (var-exp (var) (symbol->string var))
      (lambda-exp (bound-var body) (string-append "(lambda ("
                                                  (symbol->string bound-var)
                                                  ") "
                                                  (unparse-lc-exp body)
                                                  ")"))
      (app-exp (rator rand)
               (string-append "("
                              (unparse-lc-exp rator)
                              " "
                              (unparse-lc-exp rand)
                              ")")))))







