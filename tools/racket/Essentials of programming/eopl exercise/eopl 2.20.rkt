#lang racket
;Non empty bidirectional sequences of integers

;Bintree::=()|(Int Bintree Bintree)
;Nodeinsequence::= (Int Listof(Int) Listof(Int))
;NodeinBintree::=((Int Bintree Bintree) Parent-Bintree)
;Parent-Bintree::=()|(Int Bintree)

(define number->BintreeSequence
  (lambda (num)
    (list (list num '() '())
           '())))
(define left-son cadar)
(define right-son caddar)
(define parent cadr)
(define current-element caar)
(define at-leaf?
  (lambda (node)
    (and (null? (left-son node))
         (null? (right-son node)))))
(define at-root?
  (lambda (node)
    (null? (parent node))))
(define report-can-not-move-to-son-at-leaf
  (lambda (node)
  (error "at leaf can not move downward")))
(define move-to-left-son
  (lambda (node)
    (if (at-leaf? node)
        (report-can-not-move-to-son-at-leaf node)
        (list (left-son node)
              (cons (list (current-element node)
                          (right-son node))
                    (parent node))))))
(define move-to-right-son
  (lambda (node)
    (if (at-leaf? node)
        report-can-not-move-to-son-at-leaf
        (list (right-son node)
              (cons (list (current-element node)
                          (left-son node))
                    (parent node))))))
(define insert-to-left-son
  (lambda (num node)
    (list (list (current-element node)
                (list num
                      (left-son node)
                      '())
                (right-son node))
          (parent node))))
(define insert-to-right-son
  (lambda (num node)
    (list (list (current-element node)
                (left-son node)
                (list num
                      (right-son node)
                      '())
                )
          (parent node))))
(define move-up
  (lambda (node)
    (if (null? (parent node))
        #f
        (list (list (caar (parent node))
                    (car node)
                    (cadar (parent node)))
              (cdr (parent node))))))

(number->BintreeSequence 3)
(parent (number->BintreeSequence 3))
(insert-to-right-son 6 (insert-to-left-son 2 (number->BintreeSequence 3)))
(move-to-right-son (insert-to-right-son 6 (insert-to-left-son 2 (number->BintreeSequence 3))))
(move-up (move-to-right-son (insert-to-right-son 6 (insert-to-left-son 2 (number->BintreeSequence 3)))))
