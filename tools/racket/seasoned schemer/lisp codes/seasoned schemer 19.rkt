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


(define deep
  (lambda (m)
    (cond
      ((zero? m) (quote pizza))
      (else
       (cons (deep (sub1 m))
             (quote ()))))))

(define toppings (lambda (x) (quote ())))
(define deepB
  (lambda (m)
    (cond
      ((zero? m)
       (let/cc jump
         (set! toppings jump)
         (jump (quote pizza)))
       ;(quote 3)
       )
      (else (cons (deepB (sub1 m))
                  (quote ()))))))
;(deepB 6)
;(toppings 'cake)
#;(cons (toppings 'cake)
      (quote ()))
(define deep&co
  (lambda (m k)
    (cond
      ((zero? m) (k (quote pizza)))
      (else
       (deep&co (sub1 m)
                (lambda (x)
                  (k (cons x
                           (quote ())))))))))

;(deep&co 0 (lambda (x) x))
;(deep&co 6 (lambda (x) x))
;(toppings 'pizza)
(define deep&cob
  (lambda (m k)
    (cond
     ((zero? m)
      (let ()
        (set! toppings k)
        (k (quote pizza))))
     (else
      (deep&cob (sub1 m)
                (lambda (x)
                  (k (cons x (quote ())))))))))
;(deep&cob 6 (lambda (x) x))
;(toppings 'pizza)
(define leave (lambda (x) x))
(define walk
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l)) (leave (car l)))
      (else
       (let ()
         (walk (car l))
         (walk (cdr l)))))))

(define start-it
  (lambda (l)
    (let/cc here
      (set! leave here)
      (walk l))))
(define l (quote ((potato test) (chips (chips (chips (with)))) fish)))
;(start-it l)
(define fill (lambda (x) x))
(define waddle
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l)) (let ()
                         (let/cc rest
                           (set! fill rest)
                           (leave (car l)))
                           (waddle (cdr l))))
      (else (let ()
              (waddle (car l))
              (waddle (cdr l)))))))
(define start-it2
  (lambda (l)
    (let/cc here
      (set! leave here)
      (waddle l))))

;(start-it2 l)
;(fill)

(define get-next
  (lambda (x)
    (let/cc here-again
      (set! leave here-again)
      (fill (quote go)))))

;(get-next (quote go))

(define get-first
  (lambda (l)
    (let/cc here
      (set! leave here)
      (waddle l)
      (leave (quote ())))))


(define two-in-a-row*?
  (lambda (l)
    (let ((fst (get-first l)))
      (if (atom? fst)
          (two-in-a-row-b*? fst)
          #f))))
(define two-in-a-row-b*?
  (lambda (a)
    (let ((n (get-next (quote go))))
      (if (atom? n)
          (or (eq? a n)
              (two-in-a-row-b*? n))
          #f))))
(two-in-a-row*? l)

(define two-in-a-row*?a
  (letrec
      ((T? (lambda (a)
             (let ((n (get-next (quote go))))
               (if (atom? n)
                   (or (eq? a n)
                       (T? n))
                   #f))))
       (get-next
        (lambda (x)
          (let/cc here-again
            (set! leave here-again)
            (fill (quote go)))))
       (fst (lambda (l)
                    (let/cc here
                      (set! leave here)
                      (waddle l)
                      (leave (quote ())))))
       (fill (lambda (x) x))
       (leave (lambda (x) x))
       (waddle (lambda (l)
                 (cond
                   ((null? l) (quote ()))
                   ((atom? (car l)) (let ()
                                        (let/cc rest
                                          (set! fill rest)
                                          (leave (car l)))
                                      (waddle (cdr l))))
                   (else (let ()
                           (waddle (car l))
                           (waddle (cdr l))))))))
    (lambda (l)
      (if (atom? fst)
          (T? fst)
          #f))))

(two-in-a-row*?a l)


































