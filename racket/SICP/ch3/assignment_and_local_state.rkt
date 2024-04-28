#lang racket
(require "../basic_function.rkt")
#|
(define balance 100)
(define (withdraw amount)
  (if (> balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "insufficient funds"))

(define withdraw
  (let ((balance 100))
    (lambda (amount)
      (if (> balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "insufficient funds"))))

(withdraw 50)
(withdraw 51)



(define (make-withdraw balance)
  (lambda (amount)
    (if (> balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "insufficient funds")))

(define w1 (make-withdraw 100))
(define w2 (make-withdraw 100))

(w1 50)
(w1 20)
(w2 70)

|#

(define (make-account balance password)
  (let ((pt 0))
  (define (withdraw amount)
    (if (> balance amount)
        (begin (set! balance (- balance amount))
                balance)
        "insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch p m)
    (if (eq? m 'auth)
        (eq? p password)
      (if (eq? p password)
          (begin (set! pt 0)
                 (cond
                   ((eq? m 'withdraw) withdraw)
                   ((eq? m 'deposit) deposit)
                   
                   (else (error "unkonw request: make-account" m))))
          (begin (set! pt (+ pt 1))
                 
                 (if (< pt 2)
                   (lambda (v)  "incorrect password")
                   (lambda (v) "call the cops"))))))
  dispatch))

(define (make-joint ori-account password new-password)
  (let ((pt 0))
    (define withdraw (ori-account password 'withdraw))
    (define deposit (ori-account password 'deposit))
    (define (dispatch p m)
    
      (if (eq? p new-password)
          (begin (set! pt 0)
                 (cond
                   ((eq? m 'withdraw) withdraw)
                   ((eq? m 'deposit) deposit)
                   
                   (else (error "unkonw request: make-account" m))))
          (begin (set! pt (+ pt 1))
                 
                 (if (< pt 2)
                   (lambda (v)  "incorrect password")
                   (lambda (v) "call the cops")))))
          
    (if (ori-account password 'auth)
        dispatch
        (error "incorrect original password for authentication"))))

(define acc (make-account 100 'password))
(define wang-acc (make-joint acc 'password 'new))
((acc 'password 'withdraw) 50)
((wang-acc 'new 'withdraw) 40)
((acc 'password 'deposit) 40)
;((acc 'password1 'deposit) 40)
;((acc 'password1 'deposit) 40)
;((acc 'password1 'deposit) 40)
(define (make-accumulator v)
  (lambda (x)
    (begin (set! v (+ x v))
           v)))

(define A (make-accumulator 5))
;(A 10)
;(A 49)

(define (make-monitored f)
  (let ((counter 0))
    (lambda (x)
      (cond
        ((eq? x 'how-many-calls?) counter)
        ((eq? x 'reset-count)
         (set! counter 0))
        (else (set! counter (+ counter 1))
                 (f x))))))

(define B (make-monitored sqrt))
;(B 100)
;(B 9)
;(B 'how-many-calls?)
;(B 'reset-count)
;(B 'how-many-calls?)

(define (rand-update x) (random (expt 2 31)))
(define (random-init) (rand-update 0))

(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))


(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond
      ((= trials-remaining 0) (/ trials-passed trials))
      ((experiment) (iter (- trials-remaining 1)
                          (+ trials-passed 1)))
      (else
       (iter (- trials-remaining 1)
             trials-passed))))
  (iter trials 0))

;understand local variable better by making some examples
(define (g n)
  (lambda ()
  (set! n (+  n 1))
        n))
(define f
  (g 0))

(define e
  (let ((n 100))
    (lambda (x)
      (set! n (- n x))
      n)))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (* (random) range))))

(define (random-2-decimal low high)
  (define (integer low high)
    (let ((range (- high low)))
    (+ low (random range))))
  (+ (integer low high) (+ (* (random 10) 0.1) (* (random 10) 0.01))))

;exercise 3.5

(define (estimate-integral p x1 x2 y1 y2 trials)
  (define (single-test)
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
      (p x y)))
  

  (* 4.0 (monte-carlo trials single-test)))

(define (predicate  x y)
  (<= (+ (square (- x 5)) (square (- y 7))) 1))
;;(estimate-integral predicate 4.0 6.0 6.0 8.0 1000000)


(define  (factorial n)
  (let ((product 1)
        (counter 1))
    (define (iter)
      
      (if (> counter n)
                       product
                       (begin (set! product (* counter product))
                              (set! counter (+ counter 1))
                              (iter))))
    (iter)))

(define C (factorial 3))

(define x
  (let ((called 0))
    (lambda (n)
      (cond
        
        ((= called 1) (set! called 0) 0)
        (else (set! called (+ called 1)) n)))))

(+ (x 0) (x 1))
(x 0)
(+ (x 1) (x 0))




