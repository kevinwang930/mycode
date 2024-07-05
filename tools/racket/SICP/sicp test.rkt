#lang racket
(define (square x) (* x x))
(define squaret
  (lambda (x) (* x x)))
(define (m x) (lambda (y) (* x y)))
(define (>= x y) (or (> x y) (= x y)))


(define (testbig x y) (if (>= x y) x y))
(define (square-sum x y)
  (+ (square x) (square y)))
(define (big-number-square-sum x y z)
  (cond
    ((and (>= x z) (>= y z)) (square-sum x y))
    ((and (>= x y) (>= z y)) (square-sum x z))
    (else (square-sum y z))))

(define (p) (p))
(define (test x y)
(if (= x 0) 0 y))


(define (sqrt x)    ; put auxiliary function inside main function making it locally available only
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1 x))

;lexical scoping
(define (sqrt1 x)   
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  
  (define (sqrt-iter guess)
    (if (good-enough? guess)
      guess
      (sqrt-iter (improve guess))))
  (sqrt-iter 1))
(define (average x y)
   (/ (+ x y) 2))
  


(define (good-enough1? guess x)
  (= (square guess) x))


; if is special form it takes norm-order, not applicative order, it evaluates
; the predicate expression is evaluated first, the result detemines whether to'
; evaluate the consequent expression
(define (new-if predicate then-clause else-clause)
  (cond (predicate  then-clause)
        (else else-clause)))

(define (cubrt-iter guess x)
  (if (cubrt-good-enough? guess x)
      guess
      (cubrt-iter (cubrt-improve guess x) x)))
(define (cubrt-good-enough? guess x)
  (< (abs (- (* guess guess guess) x)) 0.001))
(define (cubrt-improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))
(define (cubrt x)
  (cubrt-iter 1 x))
;test
(sqrt 4.0)
(sqrt1 144)
(cubrt 27.0)