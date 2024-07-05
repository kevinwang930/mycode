#lang racket/base
(define (append x y)
  (if (null? x)
      y
      (cons (car x)
            (append (cdr x) y))))

(define a (list 1 2))
(define b (list 3 4))
;(append a b)

(define (mappend! x y)
  (set-mcdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))

(define ma (mcons 1
                  (mcons 2 '())))
(define mb (mcons 3
                  (mcons 4 '())))

;(mappend! ma mb)

(define (make-cycle x)
  (set-mcdr! (last-pair x) x)
  x)

(define z (make-cycle ma))
(set-mcdr! (mcdr mb) (mcar (mcdr mb)))

(define (cycle? x)
  (define (member? e l)
    (if (null? l)
        #f
        (or (eq? e (mcar l))
            (member? e (mcdr l)))))
  (define (help-cycle? l1 l2)
    (cond ((null? l1) #f)
          ((member? (mcar l1) l2) #t)
          (else (help-cycle? (mcdr l1) (mcons (mcar l1) l2)))))
  (help-cycle? x '()))

(define (has-cycle? xs)
  (define (seen-last-pair? x)
    (or (null? x) (null? (mcdr x))))
  (define (chase turtle rabbit)
    (cond ((or (null? turtle) (null? rabbit)) #f)
           ((eq? (mcar turtle) (mcar rabbit)) #t)
           ((seen-last-pair? (mcdr rabbit)) #f)
           (else (chase (mcdr turtle) (mcdr (mcdr rabbit))))))
  (if (seen-last-pair? xs)
      #f
      (chase xs (mcdr xs))))
;(cycle? z)


;procedual presentation of mcons
(define (ncons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else (error "Undefinedoperation:CONS" m))))
  dispatch)

(define m (ncons 1 2))
(m 'car)

(define x 'wang)
(define y 'wang)
(eq? x y)
(set! x 'wag)
(eq? x y)



 






