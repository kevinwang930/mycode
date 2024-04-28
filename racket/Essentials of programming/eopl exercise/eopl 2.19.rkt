#lang racket
;Bintree::=()|(Int Bintree Bintree)
(define number->bintree
  (lambda (num)
    (list num '() '())))
(define left cadr)
(define right caddr)
(define current-element car)
(define at-leaf?
  (lambda (bintree)
    (and (null? (left bintree))
         (null? (right bintree)))))

(define move-to-left-son
  (lambda (bintree)
    (list (current-element (left bintree))
          (left (left bintree))
          (right (left bintree)))))
(define move-to-right-son
  (lambda (bintree)
    (list (current-element (right bintree))
          (left (right bintree))
          (right (right bintree)))))

(define insert-to-left
  (lambda (num bintree)
    (list (current-element bintree)
          (list num
                (left bintree)
                '())
          (right bintree))))
(define insert-to-right
  (lambda (num bintree)
    (list (current-element bintree)
          (left bintree)
          (list num
                (right bintree)
                '()))))
(define t1 (insert-to-right 14
(insert-to-left 12
(number->bintree 13))))
(move-to-left-son t1)
(current-element (move-to-left-son t1))

