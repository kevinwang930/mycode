#lang racket
;recursion version of member?
;member? : Element*List -> boolean
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? a (car lat))
                (member? a (cdr lat)))))))
;two-in-a-row? determine if there are 2 same elements in a row in a list
;two-in-a-row? : List -> Boolean
#;(define two-in-a-row?
  (lambda (lat)
    (cond
      ((null? lat) #f)
      ((null? (cdr lat)) #f)
      (else (let ((F (car lat))
                  (S (cadr lat)))
              (or (eq? F S)
                  (two-in-a-row? (cdr lat))))))))
; The above definition of two-in-a-row? is very intuitive
#;(define two-in-a-row?
  (lambda (lat)
    (cond
      ((null? lat) #f)
      (else (or (is-first? (car lat) (cdr lat))
                (two-in-a-row? (cdr lat)))))))
;optimize the two-in-a-row to be more efficient
#|(define two-in-a-row?
  (lambda (lat)
    (cond
      ((null? lat) #f)
      (else (let ((L (cdr lat)))
              (or (is-first? (car lat) L)
                  (two-in-a-row? L)))))))
(define is-first?
 (lambda (a lat)
   (cond
     ((null? lat) #f)
     (else (eq? a (car lat)))))) |#
;above definition logic is not very clear
(define two-in-a-row?
  (lambda (lat)
    (cond
      ((null? lat) #f)
      (else (two-in-a-row-b? (car lat) (cdr lat))))))
#;(define is-first?
 (lambda (a lat)
   (cond
     ((null? lat) #f)
     ((eq? a (car lat)) #t)
     (else (two-in-a-row? lat)))))
; lat is not empty in is-first update it to be more efficient
(define two-in-a-row-b?
 (lambda (preceding lat)
   (cond
     ((null? lat) #f)
     ((eq? preceding (car lat)) #t)
     (else (two-in-a-row-b? (car lat) (cdr lat)))))) ;we can see logic is very import when you design your procedure
;sum-of-prefixes returns a new list where each element is the sum of the elements
;before and same with the positin in the original list
(define sum-of-prefixes
  (lambda (tup)
    (cond
      ((null? tup) (quote ()))
      (else (sum-of-prefixes-b 0 (car tup) (cdr tup))))))
(define sum-of-prefixes-b
  (lambda (preceding-sum preceding tup)
    (let ((Sum-now (+ preceding-sum preceding)))
      (cond
        ((null? tup) (cons Sum-now tup))
        (else (cons Sum-now
                    (sum-of-prefixes-b Sum-now (car tup) (cdr tup))))))))
(sum-of-prefixes '(1 2 3 4))

(define sum
  (lambda (lst)
    (cond
      ((null? lst) 0)
      (else (+ (car lst) (sum (cdr lst)))))))



