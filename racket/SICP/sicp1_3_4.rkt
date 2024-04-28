#lang racket
;procedures as returned values
(require "basic_function.rkt"
         "sicp1_3_3.rkt")
(define (average-damp f)
  (lambda (x) (average x (f x))))
#;(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))
(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))

;derivative of g(x)
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
(define dx 0.00001)

; with derivative we express newton's method as a fixed-point process
(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))
(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))
;formulate the function y2-x = 0 use newton method
(define (sqrt x)
  (newton-method (lambda (y) (- (square y) x)) 100))
(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))
(define (zero-point-cubic-polynomial a b c)
  (newton-method (cubic a b c) 100))
(define (double g)
  (lambda (x) (g (g x))))

#;(define (compose f g)
  (lambda (x) (f (g x))))
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
    (if (= n 1)
        f
        (compose f (repeated f (- n 1)))))
(define (smooth f)
  (lambda (x) (/ (+ (f x) (f (- x dx)) (f (+ x dx))) 3.0)))
(define (n-smooth f n)
  (repeated (smooth f) n))
;nth-average-damp to calculate nth root
(define (mth-average-damp m)
  (repeated average-damp m))
;2 different kinds of repeated , 2 different meaning
;(((repeated average-damp 2) square) 2)
;((repeated (average-damp square) 2) 2)
(define (nth-root-f x n)
  (lambda (y) (/ x (expt y (- n 1)))))
(define (fixed-point-transform f transform guess)
  (fixed-point (transform f) guess))
#;(define (nth-root x n mth-average)
  (fixed-point ((mth-average-damp  mth-average) (nth-root-f x n)) 1.0))
(define (nth-root x n mth-average)
  (fixed-point-transform  (nth-root-f x n) (mth-average-damp mth-average) 1.0))
; general method iterative improve
 
(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        (let ((new-guess (improve guess)))
          ((iterative-improve good-enough? improve) new-guess)))))
(define (iterative-improve-sqrt x)
  (let ((good-enough? (lambda (guess)
                        (< (abs (- (square guess) x)) 0.001)))
        (improve (lambda (guess)
                   (average guess (/ x guess)))))
    ((iterative-improve good-enough? improve) 1.0)))


(define (iterative-improve-fixed-point f first-guess)
  (define tolerance 0.00001)
  (define improve (lambda (guess) ((average-damp f) guess)))
  (let ((good-enough? (lambda (guess)
                        (< (abs (- guess (improve guess))) tolerance))))
    ((iterative-improve good-enough? improve) first-guess)))
;test
(define (test x root-n mth-average)
  (let ((result (nth-root x root-n mth-average)))
    (display "finished")
    (newline)))
;(test 126 6 2)


(iterative-improve-fixed-point (lambda (x) (/ 4 x)) 1)
;test
;(iterative-improve-sqrt 4)

;((repeated square 3) 2)
;((compose square inc) 6)
;((double inc) 5)
;(((double double) inc) 5)
;(((double (double double)) inc) 5)
;(zero-point-cubic-polynomial 1 -3 -5)
;(sqrt 4)
;(newton-mothod (lambda (x) (+ (- (square x) (* 4 x)) 4)) 1)
;((deriv cube) 5)
;((average-damp square) 10)
;(cube-root 8)