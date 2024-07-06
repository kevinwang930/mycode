#lang eopl
(require "eopl2.14.rkt")
(define-datatype program program?
  (a-program
   (exp1 expression?)))
(define-datatype expression expression?
  (const-exp (num number?))
  (diff-exp (exp1 expression?)
            (exp2 expression?))
  (zero?-exp (exp1 expression?))
  (if-exp (exp1 expression?)
          (exp2 expression?)
          (exp3 expression?))
  (var-exp (var identifier?))
  (let-exp (var identifier?)
           (exp1 expression?)
           (body expression?))
  (minus-exp (num number?)))
(define identifier?
  (lambda (var)
    (symbol? var)))
;init-env:()->env
(define init-env
  (lambda ()
    (extend-env 'i (num-val 1)
                (extend-env 'v (num-val 5)
                            (extend-env 'x (num-val 10)
                                        (empty-env))))))
(define-datatype expval expval?
  (num-val (num number?))
  (bool-val (bool boolean?)))
;Expressed values for LET language
;expVal->num : ExpVal -> Int
(define expval->num
  (lambda (val)
    (cases expval val
      (num-val (num)
               num)
      (bool-val (bool)
                (report-expval-extractor-error 'num val)))))
;expval->bool:ExpVal->Bool
(define expval->bool
  (lambda (val)
    (cases expval val
      (num-val (num)
               (report-expval-extractor-error 'Bool val))
      (bool-val (bool)
                bool))))
(define report-expval-extractor-error
  (lambda (expected datum)
    (eopl:error 'expval-extractor "Expected ~a, but got ~s" expected datum)))
;run:String->ExpVal
(define run
  (lambda (string)
    (value-of-program (scan&parse string))))
;value-of-program:Program ->ExpVal
(define value-of-program
  (lambda (pgm)
    (cases program pgm
      (a-program (exp)
                 (value-of exp)))))
(define value-of
  (lambda (exp env)
    (cases expression exp
      (const-exp (num)
                 (num-val num))
      (diff-exp (exp1 exp2)
                (num-val (- (expval->num (value-of exp1 env))
                            (expval->num (value-of exp2 env)))))
      (zero?-exp (exp1)
                 (let ((num1 (expval->num exp1)))
                   (if (zero? num1)
                       (bool-val #t)
                       (bool-val #f))))
      (if-exp (exp1 exp2 exp3)
              (let ((judge (expval->bool exp1)))
                (if judge
                    (value-of exp2 env)
                    (value-of exp3 env))))
      (var-exp (var)
               (apply-env env var))           ;seems problem result is number not expression type
      (let-exp (var exp1 body)
               (let ((val (value-of exp1 env)))
                 (value-of body
                           (extend-env var val env))))
      (minus-exp (num)
                 (num-val (- 0 num))))))



