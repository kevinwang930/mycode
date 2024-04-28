#lang racket
; higher order abstraction
(require (only-in "sicp1_2.rkt" prime? gcd))
(provide sum pi)
(define (sum-integers-1 a b)
  (if (> a b)
      0
      (+ a (sum-integers-1 (+ a 1) b))))
(define (sum-cubes-1 a b)
  (if (> a b)
      0
      (+ (cube a)
         (sum-cubes-1 (+ a 1) b))))
(define (pi-sum-1 a b)
  (if (> a b)
      0
      (+ (/ 1.0 (+ a (+ a 2)))
         (pi-sum-1 (+ a 4) b))))

; more general notion of accumulate combines collection of terms, using
; general accumulation function
(define (filtered-accumulate combiner null-value predicate? term next a b)
  (cond
    ((> a b) null-value)
    ((predicate? a) (combiner (term a)
                              (filtered-accumulate combiner null-value predicate? term next (next a) b)))
    (else (filtered-accumulate combiner null-value predicate? term next (next a) b))))

(define (accumulate combiner null-value term next a b)
  (define (always-true a) #t)
  (filtered-accumulate combiner null-value always-true term next a b))

#;(define (accumulate combiner null-value term next a b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term next (next a) b))))
;iterative version
#;(define (accumulate combiner null-value term next a b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (product term next a b)
  (accumulate * 1 term next a b))
(define (sum term next a b)
  (accumulate + 0 term next a b))

#;(define (sum term next a b)
  (if (> a b)
      0
      (+ (term a)
         (sum term next (next a) b))))

; iterative version of sum
#;(define (sum term next a b)
  (define (sum-iter x result)
    (if (> x b)
        result
        (sum-iter (next x) (+ result (term x)))))
  (sum-iter a 0))

(define (cube x) (* x x x))

(define (inc n) (+ n 1))
(define (sum-cubes a b)
  (sum cube inc a b))

(define (identity a) a)
(define (sum-integers a b)
  (sum identity inc a b))


(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term pi-next a b))
(define pi (* 8 (pi-sum 1 100000)))

;using sum as a building block in formulating further concepts
(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  (* (sum f add-dx (+ a (/ dx 2)) b)
     dx))

;simpon's rule integral
#;(define (simpson-integral f a b n)
  (define (sum term next a b k)
    (cond ((> k n) 0)
        ((or(= k 0) (= k n)) (+ (term a)
         (sum term next (next a) b (+ k 1))))
        ((even? k) (+ (* 2.0 (term a))
         (sum term next (next a) b (+ k 1))))
        (else (+ (* 4.0 (term a))
         (sum term next (next a) b (+ k 1))))))
  (define h (/ (- b a) n))
  (define (dx x) (+ x h))
  (/ (* h (sum f dx a b 0)) 3))

(define (simpson-integral f a b n)
  (define h (/ (- b a) n))
  (define (simpson-term k)
    (define y (f (+ a (* k h))))
    (cond
      ((or (= k 0) (= k n)) (* 1 y))
      ((even? k) (* 2 y))
      (else (* 4 y))))
  (/ (* h (sum simpson-term inc 0 n)) 3))

;abstraction of product procedure
#;(define (product term next a b)
  (if (> a b)
      1
      (* (term a)
         (product term next (next a) b))))

; iterative one

#;(define (product term next a b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))
(define (factorial n)
  (product identity inc 1 n))
(define (pi-product n)
  (define (term k)
    (define (numerator-term k)
      (cond ((= k 0) 2.0)
          ((even? k) (+ 2.0 k))
          (else (+ 3.0 k))))
    (define (denominator-term k)
      (cond ((= k 0) 3.0)
          ((even? k) (+ 3.0 k))
          (else (+ 2.0 k))))
    (/ (numerator-term k)
       (denominator-term k)))
  (* 4 (product term inc 0 n)))

(define (square x) (* x x))
(define (sum-prime a b)
  (filtered-accumulate + 0 prime? square inc a b))
(define (product-gcd n)
  (define (relative-prime? a)
     (= (gcd a n) 1))
  (filtered-accumulate * 1 relative-prime? identity inc 0 n))
;test
;(sum-prime 1 4)
;(product-gcd 7)
;(pi-product 100000)
;(factorial 3)
;(integral identity 1 3 (/ 1 100))
;(integral cube 0 1 (/ 1 100))
;(simpson-integral cube 0 1 100)
;(sum-cubes 1 3)
;(sum-integers 1 10)
;pi

