#lang racket
; Environment
;variable designates place in which values can be stored.
;The places will be maintained in structures called environments.
;An environment is a sequence of frames. Each frame is a table of bindings.


; Creation of procedure
;A procedure is pair consisting of code and pointer to the environment.
;procedure is created only be evaluating lambda expression.
;procedure code specifies parameters and procedure body.


;define creates definitions by adding bindings to frames.

;Apply a procedure
;create new environment containing a frame that binds parameters to values of arguments
;enclosing environment of this frame is environment specified by the procedure object.
;In this new environment, evaluate the procedure body.
(define (make-withdraw balance)
  (lambda (amount)
    (if (> balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "insufficient funds")))


(define  (make-withdraw-1 initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount)) balance)
          "Insufficientfunds"))))

(define  (make-withdraw-2 initial-amount)
  ((lambda (balance) 
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount)) balance)
          "Insufficientfunds")))
    initial-amount))

(define w1 (make-withdraw-2 100))

(w1 50)
(w1 25)

(mcons 1 2)