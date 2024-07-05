#lang racket
;;;-----------
;;;from section 3.3.3 for section 2.4.3
;;; to support operation/type table for data-directed dispatch

(define *the-table* (make-hash));make THE table 
(define (put key1 key2 value) (hash-set! *the-table* (list key1 key2) value));put 
(define (get key1 key2) (hash-ref *the-table* (list key1 key2) #f));get


; add type tag
(define (attach-tag type-tag content)
  (if (eq? type-tag 'integer)
      content
      (cons type-tag content)))
(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((integer? datum) 'integer)
        (else (error "Bad tagged datum: TYPE-TAG" datum))))

(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((integer? datum) datum)
        (else (error "Bad tagged datum: CONTENTS" datum))))

(provide (all-defined-out))