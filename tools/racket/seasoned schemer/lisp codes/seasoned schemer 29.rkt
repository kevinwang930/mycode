#lang racket
#lang racket


(define atom? 
(lambda (x) 
(and (not (pair? x))  (not (null? x)))))


(define add1
  (lambda (n)
    (+ n 1)))
;(add1 46)
(define sub1
  (lambda (n)
    (- n 1)))
(define o+
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (o+ (add1 n) (sub1 m))))))

(define o-
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (o- (sub1 n) (sub1 m))))))

(define o>
  (lambda (n m)
    (cond
      ((and (zero? m) (zero? n)) #f)
      ((zero? n) #f)
      ((zero? m) #t)
      (else (o> (sub1 n) (sub1 m))))))

(define o<
  (lambda (n m)
    (cond
      ((and (zero? m) (zero? n)) #f)
      ((zero? m) #f)
      ((zero? n) #t)
      (else (o< (sub1 n) (sub1 m))))))

(define o=
  (lambda (n m)
    (cond
      ((and (zero? m) (zero? n)) #t)
      ((zero? m) #f)
      ((zero? n) #f)
      (else (o= (sub1 n) (sub1 m))))))
;(o< 1 2)
;(o= 34 34)

(define o^
  (lambda (n m)
    (cond
      ((o= m 0) 1)
      (else (o* n
                (o^ n (sub1 m)))))))
;(o^ 2 3)

(define o/
  (lambda (n m)
    (cond
      ((o< n m) 0)
      (else (add1 (o/ (- n m) m))))))

(define o*
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else (o+ n
                (o* n (sub1 m)))))))
