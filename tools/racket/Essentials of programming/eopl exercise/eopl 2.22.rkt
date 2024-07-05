#lang eopl
(define-datatype stack stack?
  (empty-stack)
  (push (_val value?)
        (_stack stack?)))
(define pop
  (lambda (s)
    (cases stack s
      (empty-stack ()
                   (eopl:error 'pop "empty-stack"))
      (push (_val _stack)
                  _stack))))
(define top
  (lambda (s)
    (cases stack s
      (empty-stack ()
                   (eopl:error 'top "empty-stack"))
      (push (_val _stack)
                  _val))))
(define value?
  (lambda (v)
    #t))
(define a (push '123 (empty-stack)))
