#lang racket
;Non empty bidirectional sequences of integers
;Nodeinsequence::= (Int Listof(Int) Listof(Int))
(define number->sequence
  (lambda (num)
    (list num '() '())))
(define left cadr)
(define right caddr)
(define current-element car)
(define at-left-end?
  (lambda (node)
    (null? (left node))))
(define at-right-end?
  (lambda (node)
    (null? (right node))))

(define move-to-left
  (lambda (node)
    (list (car (left node))
          (cdr (left node))
          (cons (current-element node)
                (right node)))))
(define move-to-right
  (lambda (node)
    (list (car (right node))
          (cons (current-element node)
                (left node))
          (cdr (right node)))))

(define insert-to-left
  (lambda (num node)
    (list (current-element node)
          (cons num
                (left node))
          (right node))))
(define insert-to-right
  (lambda (num node)
    (list (current-element node)
          (left node)
          (cons num
                (right node)))))
(insert-to-right 13 '(6 (5 4 3 2 1) (7 8 9)))
(move-to-left '(6 (5 4 3 2 1) (7 8 9)))


