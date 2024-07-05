#lang racket
(require (only-in "sicp1_3.rkt" sum))
(provide pi-sum)
; constructing procedures using lambda
; lambda used to create procedures in the same way as define
; except that no name is specified for the procedure.
(define (identity x) x)
(define (square x) (* x x))
(define (pi-sum a b)
  (* 8 (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       (lambda (x) (+ x 4))
       a
       b)))
(define (integral f a b dx)
  (* (sum f
          (lambda (x) (+ x dx))
          (+ a (/ dx 2.0))
          b)
     dx))

#;(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  (* (sum f add-dx (+ a (/ dx 2)) b)
     dx))

;lambda can be used as operator in combination.
;Or more generally in any context where we could use a procedure name

;((lambda (x y z) (+ x y (square z))) 1 2 3)

;using let to create variable
;let is short form of lambda
(define (f g) (g 2))

;test
(f square)
(f (lambda (x) (* x (+ x 1))))
;(f f)
;(integral identity 1 5 0.001)
;(pi-sum 1 10000)