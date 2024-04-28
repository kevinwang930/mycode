#lang racket
(define test
    (case-lambda
     [() (test 'a)]
     [(a) (case-lambda 
           [(a) a]
           [(a b) a]
           [(a b c) a])]))
