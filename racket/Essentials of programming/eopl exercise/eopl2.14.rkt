#lang eopl
(provide (all-defined-out))
;2.14 procedural representation has-binding
;empty-env:() -> Env
(define empty-env
  (list
    (lambda (search-var)
      (report-no-binding-found search-var))
    (lambda ()
      #t)
    (lambda ()
      #f)))
;extend-env:Var*SchemeVal*Env -> Env
(define extend-env
  (lambda (saved-var saved-value saved-env)
    (list (lambda (search-var)
           (if (eq? search-var saved-var)
               saved-var
               (apply-env saved-env search-var)))
          (lambda ()
            #f)
          (lambda (search-var)
           (if (eq? search-var saved-var)
               #t
               (has-binding? saved-env search-var))))))
(define apply-env
  (lambda (env search-var)
    ((car env) search-var)))
(define report-no-binding-found
  (lambda (search-var)
    (eopl:error 'apply-env "No binding found for ~s" search-var)))

(define empty-env?
  (lambda (env)
    ((cadr env))))
(define has-binding?
  (lambda (env var)
    ((caddr env) var)))
(empty-env? empty-env)


