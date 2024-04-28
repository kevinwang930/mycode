#lang racket
(require rackunit "ex4.11.rkt")

(test-equal? "number" 1 (interpret 1))
(test-equal? "quoted symbol" 'hello (interpret '(quote hello)))
(test-case "frame"
           (test-equal? "frame" 1 (mcdr (first-binding (make-frame (list 'a)
                                                                   (list 1)))))
           )
(test-begin
 (test-equal? "definition" 1 (interpret '(let ((a 1))
                                           (define define-test 1)
                                           define-test)))
 ;(test-equal? "internal definition" 1 (interpret 'define-test))
 )
 
(test-begin
 (interpret '(define set-a 2))
 (interpret '(set! set-a 3))
 (test-equal? "assignment" 3 (interpret 'set-a)))
(test-equal? "begin" 1 (interpret '(begin (define begin-a 2)
                                          (set! begin-a 1)
                                          begin-a)))

(test-case "conditionals"
           (test-equal? "if" 1 (interpret '(if 0 1 0)))
           (test-equal? "true" true (interpret 'true))
           (test-equal? "false" false (interpret 'false)))
(test-case "if"
 (interpret '(define if-a 2))
 (test-equal? "if-consequent" 1 (interpret '(if true 1 3)))
 (test-equal? "if-alternative" 3 (interpret '(if false 1 3)))
 (test-equal? "if-consequent" 3 (interpret '(if true (+ if-a 1) 1)))
 (test-equal? "if-alternative" 3 (interpret '(if false 1 (+ if-a 1))))
 )

(test-equal? "lambda" 2 (interpret '((lambda (x y) y) 1 2)))

(test-case "procedure"
 (interpret '(define combine (let ((a 1))
                               (lambda (x)
                                 (set! a (+ a x))
                                 a))))
 (interpret '(define (accumulate-plus x)
               (if (= x 1)
                   1
                   (+ x (accumulate-plus (- x 1))))))
 (test-equal? "procedure with local variable 1" 2 (interpret '(combine 1)))
 (test-equal? "procedure with local variable 2" 3 (interpret '(combine 1)))
 (test-equal? "procedure with local variable 3" 3 (interpret '(accumulate-plus 2)))
 )

(test-case "test-or-and"
           (test-true "test-or num-list 1" (interpret '(or 1 2 3)))
           (test-equal? "test-or list #f #f 3" 3 (interpret '(or false false 3)))
           (test-false "test-or #f #f" (interpret '(or false false)))
           (test-equal? "test-and 1 2 3" 3 (interpret '(and 1 2 3))) 
           (test-false "test-and #f #f 3" (interpret '(and false false 3)))
           (test-false "test-and #f #f" (interpret '(and false false))))
(test-case "cond"
         (test-equal? "cond" (cons 1 2) (interpret '(cond (1 (cons 1 2)))))  
 (test-equal? "cond continue form" 1 (interpret '(cond ((cons 1 2) => car)))))

(test-case "let"
           (test-equal? "let 1 variable" 1 (interpret '(let ((a 1)) a)))
           (test-equal? "let 2 variable" 2 (interpret '(let ((a 1)
                                                             (b 2)) b)))
           (test-equal? "let 2 variable" 1 (interpret '(let ((a 1)
                                                             (b 2)) a)))
           (test-equal? "let 2 variable" 1
                        (interpret '(let ((a (cons 1 2))
                                          (b 2)) (car a))))
           (interpret '(define (accumulate-plus x)
              (let accumulate-iter ((sum 0)
                                    (count x))
                (if (= count 0)
                   sum
                   (accumulate-iter (+ sum count) (- count 1))))))

           (test-equal? "named-let" 6 (interpret '(accumulate-plus 3)))

           )

(test-case "let*"
           (test-equal? "let* 1 variable" 1 (interpret '(let* ((a 1)) a)))
           (test-equal? "let* 2 variable" 101 (interpret '(let* ((a 100)
                                                                 (b 101)) b)))
           (test-equal? "let* 2 dependent variable" 2 (interpret '(let* ((a 1)
                                                             (b (+ a 1))) b)))
           (test-equal? "let 2 dependent variables 2" 1
                        (interpret '(let* ((a (cons 1 2))
                                          (b a)) (car b))))
           
           )

(test-case "for"
           
           (test-equal? "for" 6 (interpret '(begin
                                              (let ((for-test 0))
                                              (for ((i (1 2 3)))
                                                (set! for-test (+ for-test i)))
                                              for-test))))
           (test-equal? "for with 2 variables" 12
                        (interpret '(begin
                                         (let ((for-test 0))                       
                                              (for ((i (1 2 3))
                                                    (j (1 2 3)))
                                                (set! for-test (+ for-test i j)))
                                              for-test))))

           )
