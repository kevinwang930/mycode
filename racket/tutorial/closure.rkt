#lang racket

(define (initclosure x)
    (define (testclosure cmd)
        (define (set11 a)
            (set! x a))
        (define (get11) x)

        (cond 
            ((eq? cmd "set")
                set11)
            ((eq? cmd "get") 
                get11)))
    (lambda (cmd)
        (testclosure cmd)))

(define init1 (initclosure 5))
(define set1 (init1 "set"))
(define get1 (init1 "get"))
(set1 10)
(get1)