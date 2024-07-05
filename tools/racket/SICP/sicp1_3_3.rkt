#lang racket
;procedure as general methods
;finding root of equations by the half-interval methods
(require "basic_function.rkt"
         "sicp1_3.rkt")
(provide fixed-point)
(define (root-search f neg-point pos-point)
  (let ((mid-point (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        mid-point
        (let ((test-value (f mid-point)))
          (cond
            ((positive? test-value) (root-search f neg-point mid-point))
            ((negative? test-value) (root-search f mid-point pos-point))
            (else mid-point))))))
(define (close-enough? x y) (< (abs (- x y)) 0.001))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond
      ((and (negative? a-value) (positive? b-value))
       (root-search f a b))
      ((and (positive? a-value) (negative? b-value))
       (root-search f b a))
      (else
       (error "values are not of opposite sign" a b)))))

(define tolerance 0.000000000001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
     (display next)
      (newline)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; formulate the square root computation as a fixed-point search y = (/ x y)
#;(define (sqrt x)
  (fixed-point (lambda (y) (/ x y)) 1.0))
;fixed-point search does not converge, improve it by y = 1/2 (Y + x/y)
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))

;using fixed-point search to compute golden ratio
#;(define golden-ratio
  (fixed-point (lambda (x) (average x (+ 1.0 (/ 1.0 x)))) 1.0))

(define (x-power n)
  (fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 2))

(define (x-power-1 n)
  (fixed-point (lambda (x) (/ (log 1000) (log x))) 2))

(define (cont-frac n d k)
  (define (recur a)
    (if (< a k)
        (/ (n a) (+ (d a) (recur (+ a 1))))
        (/ (n k) (d k))))
  (recur 1))

#;(define (cont-frac n d k)
  (define (iter a result)
    (if (>= a 1)
        (iter (- a 1) (/ (n a) (+ (d a)  result)))
        result))
  (iter k 0))

;test
#;(/ 1.0 (cont-frac (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  2))
(define frac-e (+ 2 (cont-frac (lambda (i) 1.0)
                               (lambda (i) (let ((a (/ (- i 2) 3)))
                                             (if (integer? a)
                                                 (+ 2 (* 2 a))
                                                 1)))
                               100)))

(define (tangent-frac n d k)
  (define (recur a)
    (if (< a k)
        (/ (n a) (- (d a) (recur (+ a 1))))
        (/ (n k) (d k))))
  (recur 1))
(define (count-tangent x k)
  (tangent-frac (lambda (i) (expt x i))
                (lambda (i) (+ 1 (* 2 (- i 1))))
                k))

;test
;(count-tangent (/ pi 4) 1000)
;frac-e
;(x-power 1000)
;(x-power-1 1000)
;golden-ratio
;(sqrt 4)
;(fixed-point cos 1.0)
;(half-interval-method sin 2.0 4.0)