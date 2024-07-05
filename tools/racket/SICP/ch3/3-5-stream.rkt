#lang racket
(require "../basic_function.rkt")


(define (stream-ref s n)
  (if (= n 0)
      (stream-first s)
      (stream-ref (stream-rest s) (- n 1))))

#;(define (stream-map proc s)
  (if (stream-empty? s)
      the-empty-stream
      (stream-cons (proc (stream-first s))
                   (stream-map proc (stream-rest s)))))
(define (stream-for-each proc s)
  (if (stream-empty? s)
      'done
      (begin (proc (stream-first s))
             (stream-for-each proc (stream-rest s)))))

(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))

(define (stream-empty? s) (null? s))
(define the-empty-stream '())
(define (stream-first s) (car s))
(define (stream-rest s) (force (cdr s)))
(define-syntax stream-cons
  (syntax-rules ()
    ((_ a b) (cons a (delay b)))))

(define-syntax stream-cons-1
  (syntax-rules ()
    ((_ a b) (cons a (delay-1 b)))))

(define-syntax delay
  (syntax-rules ()
    ((_ a)
     (memo-proc (lambda () a)))))w

(define-syntax delay-1
  (syntax-rules ()
    ((_ a)
     (lambda () a))))


(define (force delayed-object)
  (delayed-object))

(define (memo-proc proc)
  (let ((already-run? false)
        (result false))
    (lambda ()
      (if already-run?
          #;(begin (display "memo-proc already run  ")
                 (display result)
                 (newline)
                 result)
          result
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (stream-cons low
                   
                   (stream-enumerate-interval (+ low 1) high))))

(define (neumerate-intervel low high)
  (if (> low high)
      '()
      (cons low
                   
                   (neumerate-intervel (+ low 1) high))))

(define (stream-filter pred stream)
  (cond
    ((stream-empty? stream) the-empty-stream)
    ((pred (stream-first stream))
     (stream-cons (stream-first stream)
                  
                  (stream-filter pred (stream-rest stream))))
     (else (stream-filter pred (stream-rest stream)))))

(define (stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      the-empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply stream-map
              (cons proc
                    (map stream-rest argstreams))))))

(define (show x)
  (display-line x)
  x)
#;(define y
  (stream-map show (stream-enumerate-interval 0 10)))

;(stream-ref y 5)
;(stream-ref y 7)
;(stream-rest (stream-filter prime? (stream-neumerate-intervel 100 300)))


;(define a (delay (car (neumerate-intervel 1 1000000))))
;(cost-time (force a))
;(define a (delay (expt 2 200)))
;(cost-time (force a))
;(force a)

(define x (stream-cons 1 (stream-cons 3 2)))
;(show x)
;(define y (stream-cons 1 (stream-cons 3 2)))
;(define z (stream-map + x y))
;(stream-first (stream-rest z))
;(stream-rest (stream-rest x))
(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq
  (stream-map accum (stream-enumerate-interval 1 20)))

;(define y (stream-filter even? seq))

;(define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))
;(stream-ref y 7)
;(display-stream z)

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))


(define integers (integers-starting-from 1))
(define (divisible? x y)
  (= (remainder x y) 0))
(define no-sevens
  (stream-filter (lambda (x) (not (divisible? x 7)))
                 integers))
;(stream-ref no-sevens 100)
(define (fibgen a b)
  (stream-cons a
               (fibgen b (+ a b))))
(define fibs (fibgen 0 1))


(define (sieve stream)
  (stream-cons
   (stream-first stream)
   (sieve (stream-filter (lambda (x)
                           (not (divisible? x (stream-first stream))))
                         (stream-rest stream)))))
(define primes (sieve (integers-starting-from 2)))

;(stream-ref primes 51)
(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define ones (stream-cons 1 ones))
#;(define integers
  (stream-cons 1 (add-streams ones integers)))

(define fibs-alternative
  (stream-cons 0
               (stream-cons 1
                            (add-streams (stream-rest fibs)
                                         fibs))))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))
              stream))
(define double
  (stream-cons 1
               (scale-stream double 2)))

(define primes-1
  (stream-cons 2
               (stream-filter prime? (integers-starting-from 3))))
(define prime?
  (lambda (n)
    (define (iter ps)
      (cond
        ((> (square (stream-first ps)) n) #t)
        ((divisible? n (stream-first ps)) #f)
        (else (iter (stream-rest ps)))))
    (iter primes)))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))
(define (div-streams s1 s2)
  (stream-map / s1 s2))

(define factorial
  (stream-cons 1
               (mul-streams factorial (add-streams ones integers) )))

;(stream-ref factorial 0)
;(stream-ref factorial 3)

(define (partial-sums s)
  (add-streams s
               (stream-cons 0 (partial-sums s))))

(define sum0 (partial-sums integers))
;(stream-ref sum0 0)
;(stream-ref sum0 3)

(define (merge s1 s2)
  (cond
    ((stream-empty? s1) s2)
    ((stream-empty? s2) s1)
    (else
     (let ((s1car (stream-first s1))
           (s2car (stream-first s2)))
       (cond
         ((> s1car s2car)
          (stream-cons s2car
                       (merge s1 (stream-rest s2))))
         ((< s1car s2car)
          (stream-cons s1car
                       (merge (stream-rest s1)
                                           s2)))
         (else (stream-cons s1car
                            (merge (stream-rest s1)
                                   (stream-rest s2)))))))))
(define s
  (stream-cons 1
               (merge (scale-stream s 5) (merge (scale-stream s 3)
                                              (scale-stream s 2)))))

(define (stream-print s n)
  (define (display-inline e)
    (display e)
    (display "  "))
  (define (iter s m)
  (cond
    ((stream-empty? s)
     (display "  finished")
     (newline))
    ((= m 1)
     (display (stream-first s))
     (newline)
     (printf "~a stream elements displayed" n)     
     (newline))
    (else
     (display-inline (stream-first s))
     (iter (stream-rest s) (- m 1)))))
  (iter s n))
;(stream-ref s 1)
;(stream-ref s 2)
;(stream-ref s 3)

;(stream-print s 20)

(define (integrate-series s)
  (mul-streams s (div-streams ones integers)))

(define exp-series
  (stream-cons 1
               (integrate-series exp-series)))
;(stream-print exp-series 5)
(define cosine-series (stream-cons 1
                                   (scale-stream (integrate-series sine-series) -1)))
(define sine-series (stream-cons 0
                                 (integrate-series cosine-series)))

;(stream-print cosine-series 20)
;(stream-print sine-series 20)

(define (mul-series s1 s2)
  (stream-cons (* (stream-first s1)
                  (stream-first s2))
               (add-streams (scale-stream (stream-rest s1)
                                          (stream-first s2))
                            (mul-series s1
                                        (stream-rest s2)))))

(define cos-square+sin-square
  (add-streams (mul-series sine-series sine-series)
               (mul-series cosine-series cosine-series)))

;(stream-print cos-square+sin-square 20)

(define (invert-series s)
  (if (= (stream-first s) 0)
      (error "denominator series constant 0: invert-series")
      (let ((m (/ 1 (stream-first s))))
        (stream-cons m
                     (scale-stream (mul-series (stream-rest s) (invert-series s)) (- 0 m))))))
;(stream-print exp-series 20)
;(stream-print (invert-series exp-series) 20)
;(stream-print (mul-series exp-series (invert-series exp-series)) 20)
(define (div-series s1 s2)
  (mul-series s1 (invert-series s2)))
(define tangent-series
  (div-series sine-series cosine-series))
;(stream-print sine-series 10)
;(stream-print cosine-series 10)
;(stream-print tangent-series 10)

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (stream-cons 1
                 (stream-map (lambda (guess) (sqrt-improve guess x))
                             guesses)))
  guesses)

(define (sqrt-stream-1 x)
  
    (stream-cons 1
                 (stream-map (lambda (guess) (sqrt-improve guess x))
                             (sqrt-stream-1 x))))

(define (sqrt-stream-2 x)
  (define guesses
    (stream-cons-1 1
                 (stream-map (lambda (guess) (sqrt-improve guess x))
                             guesses)))
  guesses)
;(define a (sqrt-stream-2 2))
;(cost-time (stream-ref (sqrt-stream 2) 1000))
;(cost-time (stream-ref a 1000))
;(cost-time (stream-ref (sqrt-stream-2 2) 1000))
;(cost-time (stream-ref (sqrt-stream-1 2) 1000))
;(cost-time (stream-ref a 1000))
;(cost-time (stream-ref a 999))
(define (pi-summands n)
  (stream-cons (/ 1.0 n)
         (stream-map - (pi-summands (+ n 2)))))
(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))

;(stream-print pi-stream 10)

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (stream-cons (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-rest s)))))
(define improve-pi-stream-1 (euler-transform pi-stream))
(define improve-pi-stream-2 (euler-transform improve-pi-stream-1))

;(stream-print improve-pi-stream-1 10)
;(stream-print improve-pi-stream-2 10)

(define (make-tableau transform s)
  (stream-cons s
               (make-tableau transform (transform s))))
(define (accelerated-sequence transform s)
  (stream-map stream-first (make-tableau transform s)))

;(stream-print (accelerated-sequence euler-transform pi-stream) 20)

#;(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(define (stream-limit s tolerance)
  (if (stream-empty? (stream-rest s))
      (error 'stream-limit "failed stream finished can not find suitable tolerance")
      (let ((r0 (stream-ref s 0))
            (r1 (stream-ref s 1)))
        (if (< (abs (- (abs r0) (abs r1))) tolerance)
            r1
            (stream-limit (stream-rest s) tolerance)))))

;(sqrt 5 0.0001)

(define (ln-summands n)
  (stream-cons (/ 1.0 n)
         (stream-map - (ln-summands (+ n 1)))))
(define ln2 (partial-sums (ln-summands 1)))
(define ln2-improve (euler-transform ln2))
;(stream-print ln2 10)
;(stream-print ln2-improve 10)


(define (interleave s1 s2)
  (if (stream-empty? s1)
      s2
      (stream-cons (stream-first s1)
                   (interleave s2 (stream-rest s1)))))

(define (interleave-3 s1 s2 s3)
  (cond
    ((stream-empty? s1) (interleave s2 s3))
    ((stream-empty? s2) (interleave s1 s3))
    ((stream-empty? s3) (interleave s1 s2))
    (else
     (stream-cons (stream-first s1)
                  (stream-cons (stream-first s2)
                               (stream-cons (stream-first s3)
                                            (interleave-3 (stream-rest s1)
                                                                      (stream-rest s2)
                                                                      (stream-rest s3))))))))


(define (pairs s t)
  (stream-cons
   (list (stream-first s) (stream-first t))
   (interleave
    (stream-map (lambda (x) (list (stream-first s) x))
                (stream-rest t))
    (pairs (stream-rest s)
           (stream-rest t)))))

(define (pairs-all s t)
  (stream-cons
   (list (stream-first s) (stream-first t))
   (interleave-3
    (stream-map (lambda (x) (list (stream-first s) x))
                (stream-rest t))
    (stream-map (lambda (x) (list x (stream-first t)))
                (stream-rest s))
    
    (pairs-all (stream-rest s)
           (stream-rest t)))))

(define(pairs-1 s t)  ;this version will generate infinite loop of pairs
  (interleave (stream-map (lambda (x)  (list (stream-first s) x)) t)
              (pairs (stream-rest s) (stream-rest t))))

;(stream-ref (pairs integers integers) 392)
(define (total-elements m k)
  (define (iter m k r)
    
  (cond
    
    ((= m 1)
         (+ r k))
    ((< m k)
     (let* ((current-row-elements (+ (- k m) 1))
           (current-total-elements (+ r current-row-elements)))
         (iter (- m 1) (+ current-total-elements (- m 1)) current-total-elements)) )))
  (cond
    ((= m k 1) 1)
    ((= m k) (iter (- m 1) k 1))
    ((< m k) (iter m k (- k m 1)))))
  
(define (find-ref m k)
  (let ((a (total-elements m k)))
    (printf "total elements ~a" a)
    (- (total-elements m k) 1)))
;(stream-ref (pairs integers integers) (find-ref 5 100))
;(stream-print (pairs-all integers integers) 100)
;(stream-print (pairs-1 integers integers) 10)
;(stream-ref (pairs-1 integers integers) 1)

(define (triples t s u)
  (stream-cons
   (list (stream-first t)
         (stream-first s)
         (stream-first u))
   (interleave
    (stream-map (lambda (x) (cons (stream-first t) x))
                (stream-rest (pairs s u)))
    (triples (stream-rest t)
             (stream-rest s)
             (stream-rest u)))))


(define t (triples integers integers integers))
;(stream-print t 10)

(define pythagorean (stream-filter (lambda (x) (right-triangle? (car x)
                                                         (cadr x)
                                                         (caddr x)))
                            t))

;(stream-print pythagorean 5)

(define (merge-weighted pairweight s1 s2)
  (cond
    ((stream-empty? s1) s2)
    ((stream-empty? s2) s1)
    (else
     (let ((s1car (stream-first s1))
           (s2car (stream-first s2)))
       (cond
         ((> (pairweight s1car) (pairweight s2car))
          (stream-cons s2car
                       (merge-weighted pairweight
                                       s1
                                       (stream-rest s2))))
         ((<= (pairweight s1car) (pairweight s2car))
          (stream-cons s1car
                       (merge-weighted pairweight
                                       (stream-rest s1)
                                       s2)))
         )))))

(define (pairs-weighted weight s t)
  (stream-cons
   (list (stream-first s) (stream-first t))
   (merge-weighted weight
                   (stream-map (lambda (x) (list (stream-first s) x))
                               (stream-rest t))
                   (pairs-weighted weight
                                   (stream-rest s)
                                   (stream-rest t)))))

(define sum-weight
  (lambda (pair)
    (+ (car pair) (cadr pair))))
(define weight-b
  (lambda (pair)
    (let ((i (car pair))
          (j (cadr pair)))
      (+ (* 2 i) (* 3 j) (* 5 i j)))))
(define (<> a b)
  (not (= a b)))
(define (pred-b pair)
  (let ((i (car pair))
          (j (cadr pair)))
    (and  (<> (remainder i 2) 0)
          (<> (remainder i 3) 0)
          (<> (remainder i 5) 0)
          (<> (remainder j 2) 0)
          (<> (remainder j 3) 0)
          (<> (remainder j 5) 0))))
      

;(stream-print (pairs integers integers) 50)
;(stream-print (pairs-weighted sum-weight integers integers) 50)
;(stream-print (stream-filter pred-b (pairs-weighted weight-b integers integers)) 50)

(define weight-ramanujan
  (lambda (pair)
    (let ((i (car pair))
          (j (cadr pair)))
      (+ (* i i i) (* j j j)))))


(define (stream-ramanujan)
  
  (define (iter s weight last)
    (if (stream-empty? s)
        the-empty-stream
        (let ((R-weight (weight-ramanujan (stream-first s))))
          (if (= weight R-weight)
              (stream-cons (list weight (stream-first s) last)
                     (iter (stream-rest s) R-weight (stream-first s)))
              (iter (stream-rest s) R-weight (stream-first s))))))
  (let ((s (pairs-weighted weight-ramanujan integers integers)))
    (iter s 0 0)))
;(stream-print (pairs-weighted weight-ramanujan integers integers) 70)
;(stream-print (stream-ramanujan) 6)

(define (stream-3-way-sum-square)
  (define (weight pair) ;weight of square sum
    (let ((i (car pair))
          (j (cadr pair)))
      (+ (* i i) (* j j))))
  (define (build-same-weight-list from to)
    (let ((first (stream-first from))
          (next (stream-rest from)))
      (cond
        ((null? to)
         (build-same-weight-list next (list first)))
        ((= (weight first) (weight (car to)))
         (build-same-weight-list next (cons first to)))
        (else to))))
  (define (skip-same-weight-ele s weight-value)
    (if (= (weight (stream-first s)) weight-value)
        (skip-same-weight-ele (stream-rest s) weight-value)
        s))
  (define (iter s)
        (let* ((first-pair (stream-ref s 0))
               (first-weight (weight first-pair))
               (third-pair (stream-ref s 2))
               (third-weight (weight third-pair)))
          (cond
            ((= first-weight third-weight)
             (stream-cons (cons first-weight
                                (build-same-weight-list s '()))
                          (iter (skip-same-weight-ele (stream-rest s)
                                                      first-weight))))
            
            (else (iter (stream-rest s))))))
  (let ((s (pairs-weighted weight integers integers)))
    (iter s)))

;(stream-print (stream-3-way-sum-square) 10)

(define (integral integrand initial-value dt)
  (define int
    (stream-cons initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC R C dt)
  (lambda (stream-i v0)
    (add-streams (scale-stream stream-i R)
                 (integral stream-i v0 (/ dt C)))))

(define RC1 (RC 5 1 0.5))

;(stream-print (RC1 ones 1) 5)
(define (sign-change-detector current-value last-value)
  (cond
    ((and (< last-value 0) (>= current-value 0)) 1)
    ((and (>= last-value 0) (< current-value 0)) -1)
    (else 0)))

#;(define (make-zero-crossings input-stream last-value)
  (stream-cons
   (sign-change-detector (stream-first input-stream) last-value)
   (make-zero-crossings (stream-rest input-stream)
                       (stream-first input-stream))))


;smooth the input-stream by average
#;(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ (stream-first input-stream)
                    last-value)
                 2)))
    (stream-cons
     (sign-change-detector last-avpt avpt)
     (make-zero-crossings input-stream (stream-first input-stream) avpt))))

;make smooth a procedure to implement zero-crossing detector in a
;modular style

(define (make-zero-crossings smooth input-stream)
  (let ((smoothed-stream (smooth input-stream)))
    (stream-map sign-change-detector smoothed-stream
                (stream-cons 0 smoothed-stream))))
(define (average-smooth stream)
  (stream-map (lambda (x y)
                (/ (+ x y) 2))
              stream
              (stream-cons 0 stream)))

(define (list->stream list)
  (if (null? list)
      the-empty-stream
      (stream-cons
       (car list)
       (list->stream (cdr list)))))

(define sense-data (list->stream (list 0 0.5 7 -4 -3 -2 1)))


(define zero-crossings
  (make-zero-crossings average-smooth sense-data))


(define zero-crossings-1
  (stream-map sign-change-detector sense-data
              (stream-cons (stream-first sense-data)
                           sense-data)))



;(stream-print zero-crossings 10)
(define (delayed-integral delayed-integrand initial-value dt)
  (define int
    (stream-cons initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)
(define (solve f y0 dt)
  (define y (delayed-integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)


(define (f x) x)


(stream-ref (solve f 1 0.001) 1000)

(define (integral-1 delayed-integrand initial-value dt)
     (stream-cons
      initial-value
      (if (stream-empty? (force delayed-integrand))
          the-empty-stream
          (let ((integrand (force delayed-integrand)))
            (integral-1 (delay (stream-rest integrand))
                        (+ (* dt (stream-first integrand))
                           initial-value)
                        dt)))))
#;(define-syntax lazy-integral
  (syntax-rules ()
    ((_ integrand initial-value dt)
     (integral-1 (delay integrand) initial-value dt))))
(define (solve-1 f y0 dt)
  (define y (integral-1 (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;(stream-ref (solve-1 f 1 0.001) 1000)
;(stream-first (integral-1 sense-data 0 1))

(define (solve-2nd f a b dt y0 dy0)
  (define y (integral-1 (delay dy) y0 dt))
  (define dy (integral-1 (delay ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)
(define (g x y) (+ x y))
;(stream-print (solve-2nd g 1 1 1 0 1) 10)

(define (RLC R L C dt)
  (lambda (Vc0 Il0)
    (define Vc (integral-1 (delay dVc) Vc0 dt))
    (define Il (integral-1 (delay dIl) Il0 dt))
    (define dVc (scale-stream Il (/ 1 (- C))))
    (define dIl (add-streams (scale-stream Vc (/ 1 L))
                             (scale-stream Il (/ (- R) L))))
    (stream-map (lambda (x y) (cons x y)) Vc Il)))

(define RLC1 ((RLC 1 1 0.2 0.1) 10 0))
;(stream-ref RLC1 200)
(define (random-update) (random 4294967087))
(define (random-init seed)
  (random-seed seed)
  (random-update))
(define (random-stream seed)  
  (define (random-numbers)
    (stream-cons (random-update)
                 (random-numbers)))
  (random-seed seed)
  (random-numbers))




(define (random-numbers)
  (define (random-update new-generator)
    (random 4294967087 new-generator))
  (let ((new-generator (make-pseudo-random-generator)))
    (stream-cons
     (random-update new-generator)
     (random-numbers))))
;(stream-print (random-numbers) 10)
(define (rand seed request-stream)
  (define (dispatch m)
    (cond
      ((eq? m 'generate) (random-update))
      ((eq? m 'reset)
       (random-seed seed)
       (random-update))))
    (random-seed seed)
    (stream-map
     dispatch
     request-stream))

;(stream-print random-numbers 10)
(define (map-successive-pairs f s)
  (stream-cons
   (f (stream-first s) (stream-ref s 1))
   (map-successive-pairs f (stream-rest (stream-rest s)))))
(define cesaro-stream
  (map-successive-pairs
   (lambda (r1 r2)
     (= (gcd r1 r2) 1))
   (random-numbers)))


;(stream-print cesaro-stream 10)
  
(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (stream-cons
     (/ passed (+ passed failed))
     (monte-carlo (stream-rest experiment-stream) passed failed)))
  (if (stream-first experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define pi
  (stream-map
   (lambda (x) (if (= x 0)
                   0
                   (sqrt (/ 6 x))))
   (monte-carlo cesaro-stream 0 0)))

(define (random-numbers-range min max)
  (define (random-update new-generator)
    (+ (random min max new-generator)
       (random new-generator)))
  (define new-generator (make-pseudo-random-generator))
  (define (iter)
    (stream-cons
     (random-update new-generator)
     (iter)))
  (iter))
 (define (test-stream x y r)
    (let ((x-stream (random-numbers-range (- x r) (+ x r)))
          (y-stream (random-numbers-range (- y r) (+ y r))))
      (stream-map (lambda (x y)
                    (printf "~a ~a" x y)
                    (newline)
                    (<= (+ (square (- x r)) (square (- y r)))
                                    (square r)))
                  x-stream y-stream)))
(define (monte-carlo-circle-area x y r)
  (define test-stream
    (let ((x-stream (random-numbers-range (- x r) (+ x r)))
          (y-stream (random-numbers-range (- y r) (+ y r))))
      (stream-map (lambda (a b) (<= (+ (square (- a x)) (square (- b y)))
                                    (square r)))
                  x-stream y-stream)))
  (stream-map
   (lambda (x) (* x (square (* r 2.0))))
   (monte-carlo test-stream 0 0)))

;(stream-print (random-numbers-range 2 8) 10)
;(stream-ref (test-stream 5 7 3) 50)
;(stream-ref (monte-carlo-circle-area 5 5 3) 100000)
;(stream-print (random-numbers-range 4 10) 10)

;(stream-ref pi 3000)

#;(stream-print (rand 3 (list->stream (list 'reset 'generate 'generate
                                                  'reset 'generate 'generate))) 10)
#;(stream-print (random-numbers) 10)
#;(stream-ref (list->stream (list (cons 'reset 4) 'generate 'generate
                                                  (cons 'reset 4) 'generate 'generate)) 0)

#;(random-numbers (list->stream (list (cons 'reset 4)
                                      'generate
                                      'generate
                                      (cons 'reset 4)
                                      'generate
                                      'generate)))
































