#lang racket
(define eternity
  (lambda (x)
    (eternity x)))

(define length0
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1
             (eternity (cdr l)))))))

;(length0 '())


(define length2
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1
             ((lambda (l)
                (cond
                  ((null? l) 0)
                  (else (add1 ((lambda (l)
                                 (cond
                                   ((null? l) 0)
                                   (else (add1 (eternity (cdr l))))))
                               (cdr l))))))
              (cdr l)))))))

;(length2 '(1 2))
; length0
(((lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l)))))))
  eternity) '())
; length1
(((lambda (f)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (f (cdr l)))))))
  ((lambda (g)
     (lambda (l)
       (cond
         ((null? l) 0)
         (else (add1 (g (cdr l)))))))
   eternity)) '(1))

;length2

(((lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l)))))))
  

  ((lambda (length)
     (lambda (l)
       (cond
         ((null? l) 0)
         (else (add1 (length (cdr l)))))))
   ((lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length (cdr l)))))))
    eternity))) '(1 2))
;reduce repitions
;length 0
((lambda (make-length)
   (make-length eternity))
 (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l))))))))
;length1
((lambda (f)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (f (cdr l)))))))
 ((lambda (g)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (g (cdr l)))))))
  eternity)) 


(((lambda (make-length)
    (make-length (make-length eternity)))
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l)))))))) '(1))
;length 2
(((lambda (make-length)
    (make-length
     (make-length
      (make-length eternity))))
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l)))))))) '(1 2))
;length 3
(((lambda (make-length)
    (make-length
     (make-length
      (make-length
       (make-length eternity)))))
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l)))))))) '(1 2 3))

; subsitute eternity with make-length
;length0
(((lambda (make-length)
    (make-length make-length))
  (lambda (f)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (f (cdr l)))))))) '())
;length 
(((lambda (make-length)
    (make-length make-length))
  (lambda (f)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 ((f f)
                     (cdr l)))))))) '(1 2 3 4 5))
;extract length
#;(((lambda (make-length)
    (make-length make-length))
  (lambda (make-length)
    ((lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length
                       (cdr l)))))))
    (make-length make-length)))) '(1 2 3 4 5))

(define Y
  (lambda (le)
    ((lambda (f) (f f))
     (lambda (f)
       (le (lambda (x) ((f f) x)))))))
(define length
  (Y (lambda (f)
       (lambda (l)
         (if (null? l)
             0
             (add1 (f (cdr l))))))))
(length '(1 2 3 4 5 6))



