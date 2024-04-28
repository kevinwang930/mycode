#lang racket
(require rackunit "ex4.3.rkt")

(test-equal? "number" 1 (interpret 1))
(test-equal? "quoted symbol" 'hello (interpret '(quote hello)))
(test-begin
 (interpret '(define a 2))
 (test-equal? "definition" 2 (interpret 'a)))
(test-begin
 (interpret '(define a 2))
 (interpret '(set! a 3))
 (test-equal? "assignment" 3 (interpret 'a)))
(test-begin
 (interpret '(define a 2))
 (test-equal? "if" 3 (interpret '(if true (begin (set! a 3)
                                                 a)
                                     (begin (set! a 1)
                                            a)))))
(test-equal? "begin" 1 (interpret '(begin (define a 2)
                                          (set! a 1)
                                          a)))
(test-equal? "lambda" 2 (interpret '((lambda (x y) y) 1 2)))
(test-begin
 (interpret '(define (combine x y) (cons x y)))
 (test-equal? "procedure" (cons 1 2) (interpret '(combine 1 2))))

(test-case "test-or-and"
           (test-true "test-or num-list 1" (interpret '(or 1 2 3)))
           (test-equal? "test-or list #f #f 3" 3 (interpret '(or false false 3)))
           (test-false "test-or #f #f" (interpret '(or false false)))
           (test-equal? "test-and 1 2 3" 3 (interpret '(and 1 2 3))) 
           (test-false "test-and #f #f 3" (interpret '(and false false 3)))
           (test-false "test-and #f #f" (interpret '(and false false))))
