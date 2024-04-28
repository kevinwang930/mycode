#lang racket
(define (make-account balance password)
  (let ((pt 0)
        (protected (make-serializer)))
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
                   ((eq? m 'withdraw) (protected withdraw))
                   ((eq? m 'deposit) (protected deposit))
                   ((eq? m 'balance) )
                   (else (error "unkonw request: make-account" m))))
          (begin (set! pt (+ pt 1))
                 
                 (if (< pt 2)
                   (lambda (v)  "incorrect password")
                   (lambda (v) "call the cops"))))))
  dispatch))

(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
        (mutex 'acquire)
        (let ((var (apply p args)))
          (mutex 'release)
          var))
      serialized-p)))

(define (make-mutex)
  (let ((cell (mcons false '())))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (when (test-and-set! cell)
                 (the-mutex 'acquire)))
            ((eq? m 'release) (clear! cell))))
    the-mutex))
(define (clear! cell)
  (set-mcar! cell false))

(define (test-and-set! cell)
  (if (mcar cell)
      true
      (begin (set-mcar! cell true)
             false)))


