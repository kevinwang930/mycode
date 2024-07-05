#lang racket
(define lazy+ (lambda () (apply + (build-list 5000000 values))))
(define (make-lazy+ i)
  (lambda ()
    (apply + (build-list (* 500 i) values))))
(define long-big-list (build-list 5000 make-lazy+))
(define (compute-every-1000th l)
  (for/list ([thunk l] [i (in-naturals)]
                       #:when (zero? (remainder i 1000)))
    (thunk)))
(compute-every-1000th long-big-list)

(define (memoize suspended-c)
  (define hidden #f)
  (define run? #f)
  (lambda ()
    (cond [run? hidden]
          [else (set! hidden (suspended-c))
                (set! run? #t)
                hidden])))

(define mlazy+ (memoize lazy+))

(define (test)
  (+ 1 1))
(define (test1 test)
  (lambda ()
    (+ (test) 1)))
(define (memoize.v2 suspended-c)
  (define (hidden)
    (define the-value (suspended-c))
    (set! hidden (lambda () the-value))
    the-value)
  (lambda () (hidden)))
(define lazy (memoize.v2 lazy+))
(define (memoize.v3 suspended-c)
  (define hidden (suspended-c))
  hidden)
(define lazy3 (memoize.v3 lazy+))





