#lang racket

(define (make-simplified-withdraw balance)
  (lambda (amount)
    (set! balance (- balance amount))
    balance))

(define (stream-withdraw balance amount-stream)
  (stream-cons
   balance
   (stream-withdraw (- balance (stream-first amount-stream))
                    (stream-rest amount-stream))))

