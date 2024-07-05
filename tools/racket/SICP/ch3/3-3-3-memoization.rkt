#lang racket/base
(require "../basic_function.rkt")
(require "3-3-3-tables.rkt")

(define  (memoize f)
  (let ((table (make-table)))
   (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

(define(fib n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    (else (+ (fib(- n 1)) (fib (- n 2))))))



;this memoize-version write by myself
; not modularlized 
(define memo-fib
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (cond
                            ((= x 0) 0)
                            ((= x 1) 1)
                            (else (+ (memo-fib (- x 1))
                                     (memo-fib (- x 2)))))))
              (insert! x result table)
              result))))))
(define memo-fib-1
  (memoize
   (lambda (n)
     (cond ((= n 0) 0)
           ((= n 1) 1)
           (else (+ (memo-fib-1 (- n 1))
                    (memo-fib-1 (- n 2))))))))



(cost-time (memo-fib 10000))

(cost-time (memo-fib-1 10000))
