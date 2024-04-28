#lang racket
;(require "test.rkt")
;((get 'addx) 1 2)

(define x 12)
(define-syntax m
  (syntax-rules ()
    [(_ id) (let ([x 10]) id)]))
(define-syntax n
  (syntax-rules ()
    [(_ id) (let ([id 5])
                x)]))
(m x)
(n x)

#;(define-syntax fun
  (syntax-rules ()
    [(_ id) id]))



(define (dummy1)
  (let ((x 5))
    (fun x)))
