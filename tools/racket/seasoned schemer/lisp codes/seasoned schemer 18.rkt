#lang racket


(define add1
  (lambda (n)
    (+ n 1)))
;(add1 46)
(define sub1
  (lambda (n)
    (- n 1)))
;(sub1 47)
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
(define l '(1 2 3))
#;(define kar
  (lambda (c)
    (c (lambda (a d) a))))
#;(define kdr
  (lambda (c)
    (c (lambda (a d) d))))
#;(define kons
  (lambda (kar kdr)
    (lambda (selector)
      (selector kar kdr))))


;(kar (kons 1 2))
;(kar (kons 1 (kons 2 (quote ()))))

;(lenkth (lots 6))
(define counter (lambda () (quote ())))
(define set-counter (lambda () (quote ())))

;(set-counter 0)
;(lenkth (add-at-end (lots 6)))
;(counter)


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

(define add-at-end
  (lambda (l)
    (cond
      ((null? (kdr l)) (konsC (kar l)
                              (konsC (quote egg)
                                    (quote ()))))
      (else
       (konsC (kar l)
              (add-at-end (kdr l)))))))
#;(define add-at-end-too
  (lambda (l)
    (cond
      ((null? (kdr l)) (set-kdr l (konsC (quote egg)
                                         (quote ())))))))
(define add-at-end-too
  (lambda (l)
    (letrec ((A (lambda (ls)
                  (cond
                    ((null? (kdr ls)) (set-kdr ls (konsC (quote egg)
                                                         (quote ()))))
                    (else (A (kdr ls)))))))
      (A l)
      l)))
(define dozen (lots 12))
(define bakers-dozen (add-at-end dozen))
(define bakers-dozen-too (add-at-end-too dozen))
(define bakers-dozen-again (add-at-end dozen))
(define eklist?
  (lambda (s1 s2)
    (cond
      ((null? s1) (null? s2))
      ((null? s2) #f)
      ((eq? (kar s1) (kar s2)) (eklist? (kdr s1) (kdr s2)))
      (else #f))))
;(eklist? bakers-dozen bakers-dozen-too)
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

;(same? dozen bakers-dozen-too)
(define last-kons
  (lambda (ls)
    (cond
      ((null? (kdr ls)) ls)
      (else (last-kons (kdr ls))))))
(define long (lots 2))
;(lenkth (last-kons long))
(set-kdr (last-kons long) long)

;(last-kons dozen)
(define finite-lenkth
  (lambda (p)
    (let/cc infinite
      (letrec
          ((C (lambda (p q)
                (cond

                  ((null? q) 0)
                  ((same? p q) (infinite #f))
                  ((null? (kdr q)) 1)
                  (else
                   (o+ (C (sl p) (qk q))
                       2)))))
           (qk (lambda (x) (kdr (kdr x))))
           (sl (lambda (x) (kdr x))))
        (cond
          ((null? p) 0)
          (else (add1 (C p (kdr p)))))))))
;(set-kdr (last-kons long) dozen)
;(finite-lenkth dozen)
(lenkth dozen)
(finite-lenkth long)




 



















