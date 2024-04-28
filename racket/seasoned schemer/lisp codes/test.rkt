#lang racket

(define atom? 
(lambda (x) 
(and (not (pair? x))  (not (null? x)))))

(define counter (lambda () (quote ())))
(define set-counter (lambda () (quote ())))

(define bons
  (lambda (kar)
    (let ((kdr (quote ())))
      (lambda (selector)
        (selector
         (lambda (x) (set! kdr x))
         kar
         kdr)))))
(define kar
  (lambda (c)
    (c (lambda (s a d) a))))
(define kdr
  (lambda (c)
     (c (lambda (s a d) d))))
(define set-kdr
  (lambda (c x)
    ((c (lambda (s a d) s)) x)))
(define kons
  (lambda (a d)
    (let ((c (bons a)))
      (set-kdr c d)
        c)))    
;(kdr (kons 1 2))


(define lenkth
  (lambda (l)
    (cond
      ((null? l) 0)
      (else
       (add1 (lenkth (kdr l)))))))
;(lenkth (lots 12))

(define konsC
  (let ((N 0))
    (set! counter (lambda () N))
    (set! set-counter (lambda (x) (set! N x)))
  (lambda (x y)
    (set! N (add1 N))
    ;(set! counter N)
    (kons x y))))


(define lots
  (lambda (n)
    (if (= n 0)
        (quote ())
        (konsC (quote egg)
               (lots (sub1 n))))))

(define same?
  (lambda (c1 c2)
    (let ((t1 (kdr c1))
          (t2 (kdr c2)))
      (set-kdr c1 1)
      (set-kdr c2 2)
      (let ((v (= (kdr c1) (kdr c2))))
        (set-kdr c1 t1)
        (set-kdr c2 t2)
        v))))

(define dozen (lots 12))
(define finite-lenkth
  (lambda (p)
    (let/cc infinite
      (letrec
          ((C (lambda (p q)
                (cond
                  ((same? p q) (infinite #f))
                  ((null? q) 0)
                  ((null? (kdr q)) 1)
                  (else
                   (+ (C (sl p) (qk q))
                       2)))))
           (qk (lambda (x) (kdr (kdr x))))
           (sl (lambda (x) (kdr x))))
        (cond
          ((null? p) 0)
          (else (add1 (C p (kdr p)))))))))

(finite-lenkth dozen)



