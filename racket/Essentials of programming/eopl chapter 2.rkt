#lang racket

#|
(define plus
  (lambda (x y)
    (if (is-zero? x)
        y
        (successor (plus (predecessor x) y)))))

;big number representation
(define *base* 10)
(define *base-sub-1* (- *base* 1))

(define zero '())
(define is-zero?
  (lambda (n)
    (null? n)))
(define successor
  (lambda (n)
    (if (is-zero? n)
        '(1)
        (let ((lowest-digit (car n)))
          (if (= lowest-digit *base-sub-1*)
            (cons 0 (successor (cdr n)))
            (cons (+ lowest-digit 1)
                  (cdr n)))))))

(define predecessor
  (lambda (n)
    (let ((lowest-digit (car n))
          (rest-digit (cdr n)))
       (if (= lowest-digit 0)
           (cons *base-sub-1*
                 (predecessor rest-digit))
           (if (and (= lowest-digit 1) (null? rest-digit))
               zero
               (cons (- lowest-digit 1) rest-digit))))))
(define multiply
  (lambda (m n)
    (if (or (is-zero? m) (is-zero? n))
        zero
        (plus m (multiply m (predecessor n))))))
(define factorial
  (lambda (n)
    (if (is-zero? n)
        '(1)
        (multiply n (factorial (predecessor n))))))
 
(plus '(1) '(9))
(successor '(1 0 0 1))
(predecessor '(0 0 0 1))
(successor '())
(multiply '(8) '(9))
(factorial '(5))

|#
; zero is-zero? successor predecessor
#|(define one '(one))
(define zero '(diff (one) (one)))
(define predecessor
  (lambda (n)
    (list (quote diff)
          n
          one)))
(define successor
  (lambda (n)
    (let ((t1 (cadr n))
          (t2 (caddr n)))
      (list (quote diff)
            t1
            (predecessor t2)))))
(define plus
  (lambda (n1 n2)
    (let ((sub  (list (quote diff)
                      zero
                      n2)))
      (list (quote diff)
            n1
            sub))))

(predecessor zero)
(successor zero)
(plus zero zero)   |#

; Env = (empty-env)|(extend-env Val schemeVal Env)
; Var = Sym
;empty-env:() -> Env
#|(define empty-env
  (lambda ()
    (list 'empey-env)))
;extend-env:Val*SchemeVal*Env -> Env
(define extend-env
  (lambda (val schemeval env)
    (list 'extend-env
          val
          schemeval)
          env))
;apply-env:Env*Val -> SchemeVal
(define apply-env
  (lambda (env search-var)
    (cond
      ((eq? (car env) 'empty-env)
       (report-no-binding-found search-var))
      ((eq? (car env) 'extend-env)
       (let ((saved-var (cadr env))
             (saved-value (caddr env))
             (saved-environment (cadddr env)))
         (if (eq? saved-var search-var)
             saved-value
             saved-environment)))
      (else
       (report-invalid-env env)))))
(define report-no-binding-found
  (lambda (search-var)
    (error 'apply-env "No binding found for ~s" search-var)))
(define report-invalid-env
  (lambda (env)
    (error 'apply-env "Bad environment ~s" env))) |#
#|
;empty-env -> ()
(define empty-env '())
;empty-env?*Env-> Boolean
(define empty-env?
  (lambda (env)
    (null? env)))
;extend-env:Val*SchemeVal*Env -> Env
(define extend-env
  (lambda (var val env)
    (cons (list var val)
          env)))
;apply-env:Symbol*Env -> Value
(define apply-env
  (lambda (sym env)
    (cond
      ((empty-env? env) (report-no-binding-found sym))
      ((eq? (caar env) sym) (cadar env))
      (else (apply-env sym (cdr env))))))
(define report-no-binding-found
  (lambda (search-var)
    (error 'apply-env "No binding found for ~s" search-var)))  |#

;2.12 Stack procedural representation
;empty-stack*() -> stack
;interprepter stack
#|(define empty-stack
  (lambda ()
    '()))
(define saved-stack empty-stack)


(define push
  (lambda (var)
    (set! saved-stack (cons var
          saved-stack))))
(define pop
  (lambda ()
    (let ((stack saved-stack))
      (if (null? saved-stack)
          report-no-stack-value
          (set! saved-stack (cdr saved-stack))
          (car stack)))))   |#

#|(define empty-stack
  (lambda (stack)
    (lambda (command)
      (cond ((eq? command 'pop) report-no-binding-found command)))))
(define report-no-binding-found
  (lambda (search-var)
    (error 'pop "empty stack")))
(define push
  (lambda (var stack)
     (lambda (command)
       (cond
         ((eq? command 'pop) stack)
         ((eq? command 'top) var)
         ((eq? command 'empty?) #f)))))
(define pop
  (lambda (stack)
    (stack 'pop)))
(define top
  (lambda (stack)
    (stack 'top)))
(define empty-stack?
  (lambda (stack)
    (stack 'empty?)))

(define s1 (push 2 empty-stack))
(define s2 (push 3 s1))
(define s3 (push 4 s2))
(pop s3)
(top s3)
(empty-stack? s1)  |#



         












 



