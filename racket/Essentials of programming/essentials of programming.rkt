#lang racket
(define in-s?
  (lambda (n)
          (if (zero? n) #t
              (if (>= (- n 3) 0)
                  (in-s? (- n 3))
                  #f))))


(define in-s1?
  (lambda (n k)
    (cond
      ((and (zero? n) (zero? (- k 1))) #t)
       ((and (>= (- n 1) 0) (>= (- k 7) 1)) (in-s1? (- n 1) (- k 7))))))

(define alphalist '(a b c d f g i j k))

;(in-s1? 1 8)

#|ist-length : List → Int          contract   
usage: (list-length l) = the length of l
(define list-length
(lambda (lst)
...))|#

(define list-length
  (lambda (l)
    (if (null? l)
        0
        (+ 1 (list-length (cdr l))))))

;(list-length '(ab b c))
;(list-ref '(ab b c) 2)

#|Exercise 1.7  The error message from nth-element is uninformative. Rewrite
nth-element so that it produces a more informative error message, such as “(a b
c) does not have 8 elements.”   |#
(define nth-element
  (lambda (l n)
    (nth-element-helper l n l n)))
(define nth-element-helper
  (lambda (list n current-list i)
    (cond
      ((null? current-list) (list-too-short list n))
      ((zero? i) (car current-list))
      (else (nth-element-helper list n (cdr current-list) (- i 1))))))

(define list-too-short
  (lambda (list n)
    (error 'nth-element 
           "~s List does not have ~s  elements.~%" list (+ n 1))))
;(list-length alphalist)
;(nth-element alphalist 9)


