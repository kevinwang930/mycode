#lang racket
(#%require (lib "27.ss" "srfi"))
(provide prime?
         gcd)
;factorial function

;linear recursion
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
;linear-iteration
(define (factorial1 n)
  (define (factorial-help m)
    (if (> m n)
        1
        (* m (factorial-help (+ m 1)))))
  (factorial-help 1))
(define (factorial2 n)
  (define (factorial-iter product counter)
    (if (> counter n)
        product
        (factorial-iter (* product counter)
                        (+ counter 1))))
  (factorial-iter 1 1))


(define (A x y)
(cond ((= y 0) 0)
      ((= x 0) (* 2 y))
      ((= y 1) 2)
      (else (A (- x 1) (A x (- y 1))))))
(define (f n)
  (A 0 n))
(define (g n)
  (A 1 n))
(define (h n)
  (A 2 n))


;fibonacci    tree recursive
(define (fib n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    (else (+ (fib (- n 1)) (fib (- n 2))))))
;fibonacci iterative function
(define (fibi n)
  (define (fib-iter fi fi1 count)
    (if (= count 0)
        fi
        (fib-iter fi1 (+ fi fi1) (- count 1))))
  (fib-iter 0 1 n))
(define (fast-fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))
                   (+ (* 2 p q) (square q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

;counting change
;1/2a + 1/4b + 1/10c+ 1/20d + 1/100e = 1 
(define (count-change amount)
  (define (first-denomination kind-of-coins)
    (cond
      ((= kind-of-coins 1) 1)
      ((= kind-of-coins 2) 5)
      ((= kind-of-coins 3) 10)
      ((= kind-of-coins 4) 25)
      ((= kind-of-coins 5) 50)))
  (define (cc amount kind-of-coins)
    (cond
      ((= amount 0) 1)
      ((or (< amount 0) (= kind-of-coins 0)) 0)
      (else  (+ (cc (- amount (first-denomination kind-of-coins)) kind-of-coins)
                (cc amount (- kind-of-coins 1))))))
  (cc amount 5))

(define (f1 n)
  (if (< n 3)
      n
      (+ (f1 (- n 1)) (* 2 (f1 (- n 2))) (* 3 (f1 (- n 3))))))
(define (f2 n)
  (define (f2-iter a1 a2 a3 count)
        (cond
          ((= count n) a3)
          (else (f2-iter a2 a3 (+ a3 (* 2 a2) (* 3 a1)) (+ count 1)))))
  (if (< n 3)
      n
      (f2-iter 0 1 2 2)))
;pascal's triangle
(define (pascal-triangle row column)
  (if (or (= column 1) (= row column))
      1
      (+ (pascal-triangle (- row 1) (- column 1))
         (pascal-triangle (- row 1) column))))

; sin of angle

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

;exponential
(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))
;ab^n = ab*b^(n-1)
(define (expt-1 b n)
  (define (expt-iter result count)
    (if (= count 0)
        result
        (expt-iter (* b result) (- count 1))))
  (expt-iter 1 n))
;B^2n = (B^2)^n   expotentiation improve
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (square x) (* x x))

(define (fast-expt-1 b n)
  (define (expt-iter base product count exp)
    (cond ((= count exp) product)
          ((<= (* 2 count) exp) (expt-iter base (square product) (* 2 count) exp))
          (else (expt-iter base (* base product) (+ count 1) exp))))
  (if (= n 0)
      1
      (expt-iter b b 1 n)))

(define (fast-expt-2 b n)
  (define (expt-iter  a b n)
    (cond ((= n 0) a)
          ((even? n) (expt-iter a (square b) (/ n 2)))
          (else (expt-iter (* a b) b (- n 1)))))
  (expt-iter 1 b n))

;calculate multiply by using addition.
;(* a b) = (+ a (* a (- b 1)))
(define (*-s a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))
;reduce the space use by logarithmic steps with halve double
;(* a b) = (* (double a) (halve b))
(define (*1 a b)
  (cond
    ((or (= b 0) (= a 0)) 0)
    ((even? b) (*1 (double a) (halve b)))
    (else (+ a (*1 a (- b 1))))))
(define (double a)
  (+ a a))
(define (halve b)
  (/ b 2))

(define (*i a b)
  (define (*-iter a b n)
    (cond
      ((= b 0) n)
      ((even? b) (*-iter (double a) (halve b) n))
      (else (*-iter a (- b 1) (+ a n)))))
  (if (or (= a 0) (= b 0))
      0
      (*-iter a b 0)))
; greatest common divisor gcd
; gcd(a b) = gcb ( b reminder(a/b))
;r = na-mb
;r/cd = (na-mb)/cd
;gcd(a b) = gcd(b r)
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;prime number problem
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? test-divisor n)
  (= (remainder n test-divisor) 0))

(define (prime? n)
  (if (<= n 1)
      #f
      (= (smallest-divisor n) n)))

;fermat's algorithm

(define (expmod base exp m)
  (cond
    ((= exp 0) 1)
    ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
    (else (remainder (* base (expmod base (- exp 1) m)) m))))
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ (random-integer (- n 1)) 1)))

(define (fast-prime? n times)
  (cond
    ((= times 0) true)
    ((fermat-test n) (fast-prime? n (- times 1)))
    (else false)))
;calculate time consumed

(define (report-prime elapsed-time)
  (display " ** ")
  (display elapsed-time))
(define (timed-prime-test current-test prime-count)
    (newline)
    (display current-test)
    (start-prime-test current-test (current-milliseconds) prime-count))
(define (start-prime-test current-test start-time prime-count)
    (cond
      ((prime? current-test) (report-prime (- (current-milliseconds) start-time))
                  (search-for-primes  (+ current-test 1) (- prime-count 1)))
      (else (search-for-primes (+ current-test 1) prime-count))))

(define (search-for-primes current-test prime-count)

  (cond
    ((= prime-count 0) (display " finished "))
    (else (timed-prime-test current-test prime-count))))

;improve smallest divisor this new algorithem reduced the calculation time by half

(define (smallest-divisor-1 n) 
  (define (find-divisor n test-divisor)
    (cond ((>= (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (define (divides? test-divisor n)
    (= (remainder n test-divisor) 0))
  (define (next test-divisor)
     (if (= test-divisor 2)
         3
         (+ test-divisor 2)))
  (find-divisor n 2))
(define (prime?-1 n)
  (= (smallest-divisor-1 n) n))


(define (search-for-primes-1 current-test prime-count)
(define (report-prime elapsed-time)
  (display " ** ")
  (display elapsed-time))
(define (timed-prime-test current-test prime-count)
    (newline)
    (display current-test)
    (start-prime-test current-test (current-milliseconds) prime-count))
(define (start-prime-test current-test start-time prime-count)
    (cond
      ((prime?-1 current-test) (report-prime (- (current-milliseconds) start-time))
                  (search-for-primes-1  (+ current-test 1) (- prime-count 1)))
      (else (search-for-primes-1 (+ current-test 1) prime-count))))
  (cond
    ((= prime-count 0) (display " finished "))
    (else (timed-prime-test current-test prime-count))))
(define (search-for-primes-2 current-test prime-count)
(define (report-prime elapsed-time)
  (display " ** ")
  (display elapsed-time))
(define (timed-prime-test current-test prime-count)
    ;(newline)
    ;(display current-test)
    (start-prime-test current-test (current-milliseconds) prime-count))
(define (start-prime-test current-test start-time prime-count)
    (cond
      ((fast-prime? current-test 10) (report-prime (- (current-milliseconds) start-time))
                  (search-for-primes-2  (+ current-test 1) (- prime-count 1)))
      (else (search-for-primes-2 (+ current-test 1) prime-count))))
  (cond
    ((= prime-count 0) (display " finished "))
    (else (timed-prime-test current-test prime-count))))
(define (digit-generator  n digit)
  (if (= digit 0)
      n
      (digit-generator (* n 10) (- digit 1))))

; for the numbers fermat test does not work
(define (carmi-number? n)
  (define (congruent-test n a)
    (cond
      ((>= a n) #t)
      ((= (expmod a n n) a) (congruent-test n (+ a 1)))
      (else #f)))
  (congruent-test n 2))


;Miller-Rabin test
(define (nontrivial-sqrt-check x n)
  (define square-modulo (remainder (square x) n))
  (if (and
       (= square-modulo 1)
       (not (= x 1))
       (not (= x (- n 1))))
      0
      square-modulo))
(define (miller-rabin-expmod base exp m)
  (cond
    ((= exp 0) 1)
    ((even? exp) (nontrivial-sqrt-check (miller-rabin-expmod base (/ exp 2) m) m))
    (else (remainder (* base (expmod base (- exp 1) m)) m))))
(define (miller-rabin-test n)
  (define (try-it a)
    (= (miller-rabin-expmod a (- n 1) n) 1))
  (try-it (+ (random-integer (- n 1)) 1)))

(define (improved-prime? n times)
  (cond
    ((= times 0) true)
    ((miller-rabin-test n) (improved-prime? n (- times 1)))
    (else false)))
;test
;(carmi-number? 561)
;(miller-rabin-test 100000000000097)



;(prime? 100000000000097)
;(search-for-primes   1000000000000001 3)
;(search-for-primes-1 100000000000001 3)
;(search-for-primes-2 (digit-generator 1 120) 3)
;(search-for-primes-2 (digit-generator 1 240) 3)
;(fast-prime? 2500000001 5)
;(smallest-divisor  (* 987643212342383 98764321234259))
;(smallest-divisor 100000001)
;(smallest-divisor 1999)
;(smallest-divisor 19999)
;(prime? 13)
;(fast-prime? 135 5)
;(expmod 6 13 13)
;(modulo (expt 6 13) 13)
;(gcd 3 40)
;(* 5 2000000)
;(*i 5 2000000)
;(fast-expt 2 1000)
;(fast-expt-1 2 1000)
;(fast-expt-2 2 1000)
;(factorial 100)
;(factorial1 6)
;(factorial2 6)
;(A 1 10)
;(A 2 4)
;(A 3 3)
;(f 10)
;(g 10)
;(h 2)
;(fib 2)
;(fib 3)
;(fib 5)
;(fibi 100)
;(fast-fib 100)
;(count-change 100)
;(f1 10)
;(f2 10)
;(pascal-triangle 5 3)
;(sine 1.57)

