#lang eopl
(define error eopl:error)
(define-datatype lc-exp lc-exp?
(var-exp
 (var var-exp?))
(lambda-exp
 (bound-var symbol?)
 (body lc-exp?))
(app-exp
 (rator lc-exp?)
 (rand lc-exp?)))
(define var-exp?
  (lambda (v)
    (if (eq? v 'lambda)
        #f
        (symbol? v))))
;occurs-free? :Sym*LcExp -> Bool
(define occurs-free?
  (lambda (search-var exp)
    (cases lc-exp exp
      (var-exp (var) (eq? var search-var))
      (lambda-exp (bound-var body)
                  (and
                   (not (eq? bound-var search-var))
                   (occurs-free? search-var body)))
      (app-exp (rator rand)
               (or (occurs-free? search-var rator)
                   (occurs-free? search-var rand))))))

;S-list::=({S-exp}*)
;S-exp::=Symbol | S-list
#|(define-datatype s-list s-list?
  (empty-s-list)
  (non-empty-s-list
   (first s-exp?)
   (rest s-list?)))      |#
(define-datatype s-exp s-exp?
  (symbol-s-exp
   (sym symbol?))
  (s-list-s-exp
   (slst s-list?)))
(define-datatype s-list s-list?
  (an-s-list
   (sexps (list-of s-exp?))))
(define list-of
  (lambda (pred)
    (lambda (val)
      (or (null? val)
          (and (pair? val)
               (pred (car val))
               ((list-of pred) (cdr val)))))))

;Env = (Empty-env) | (extend-env Var SchemeVal Env)
;Var = Sym
(define value?
  (lambda (v)
    #t))
(define-datatype env env?
  (empty-env-inter)
  (extend-env-inter (_var symbol?)
                    (_val value?)
                    (_env env?)))
(define empty-env
  (empty-env-inter))
(define extend-env extend-env-inter)

(define apply-env
  (lambda (var E)
    (cases env E
      (empty-env-inter ()
                       (error 'apply-env "no binding found"))
      (extend-env-inter (_var _val _env)
                        (if (eqv? var _var)
                            _val
                            (apply-env var _env))))))
(define has-binding?
  (lambda (var E)
    (cases env E
      (empty-env-inter ()
                       #f)
      (extend-env-inter (_var _val _env)
                        (if (eq? var _var)
                            #t
                            (has-binding? var _env))))))



(define e empty-env)
(define a (extend-env 'a 1 e))
(define b (extend-env 'a 2 a))
(define c (extend-env 'b 3 b))








