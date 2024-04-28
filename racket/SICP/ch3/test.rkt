#lang racket
(define (a) (lambda () (+ 2 2)))
;((a))
(define b (lambda () + 2 2))
;(b)


;local variable test
(define local-add
  (let ((y 0))
    (lambda (x)
      (set! y (+ y 1))
    (printf "local value y is ~a~n" y))))
#|
(local-add 6)
(local-add 6)
(local-add 6)
(local-add 6)
(local-add 6)
|#

;key-word argument test
(define (test b c #:1 a) b)
;(test  #:1 1 2 3)

;(printf "value of x is ~a" x)

(define-syntax delay
  (syntax-rules ()
    ((_ a)
     (lambda () a))))


(define (force delayed-object)
  (delayed-object))

(define (stream-first s) (car s))
(define (stream-rest s) (force (cdr s)))
(define-syntax stream-cons
  (syntax-rules ()
    ((_ a b) (cons a (delay b)))))
(define-syntax t
  (syntax-rules ()
    ((_  n)
  
   (cons
    n
   (lambda ()
     n)))))

(define (test-1 x)
  (define (dispatch request)
    (cond
      ((eq? request 1) 1)))
  dispatch)
((test-1 4) 1)


(define ma (mcons 1 2))
(define mb (cons 3 4))
(set-mcar! ma 2)
(define mc (mcar ma))
(define md (cons ma mb))

