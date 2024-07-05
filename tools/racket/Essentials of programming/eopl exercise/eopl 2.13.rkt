#lang racket
;procedural expression
;empty-env:() -> Env
(define empty-env
  (list
    (lambda (search-var)
      (report-no-binding-found search-var))
    (lambda ()
      #t)))
;extend-env:Var*SchemeVal*Env -> Env
(define extend-env
  (lambda (saved-var saved-value saved-env)
    (list (lambda (search-var)
           (if (eq? search-var saved-var)
               saved-var
               (apply-env saved-env search-var)))
          (lambda ()
            #f))))
(define apply-env
  (lambda (env search-var)
    ((car env) search-var)))
(define report-no-binding-found
  (lambda (search-var)
    (error 'apply-env "No binding found for ~s" search-var)))

(define empty-env?
  (lambda (env)
    ((cadr env))))

(empty-env? empty-env)
(apply-env  (extend-env 'a 3 empty-env) 'a)