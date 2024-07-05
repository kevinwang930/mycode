#lang racket/base
(require "3-3-3-tables.rkt")


(define (make-table1)
  (mcons '*table* '()))

(define (lookup key-1 key-2 table)
  (let ((subtable (assoc key-1 (mcdr table))))
    (if subtable
        (let ((record (assoc key-2 (mcdr subtable))))
          (if record
              (mcdr record)
              #f))
        #f)))

(define (insert key-1 key-2 value table)
  (let ((subtable (assoc key-1 (mcdr table))))
    (if subtable
        (let ((record (assoc key-2 (mcdr subtable))))
          (if record
              (set-mcdr! record value)
              (set-mcdr! subtable
                         (mcons (mcons key-2 value)
                                (mcdr subtable)))))
        (set-mcdr! table
                   (mcons (mcons key-1
                                 (mcons (mcons key-2 value)
                                        '()))
                          (mcdr table)))))
  'ok)


(define operation-table (make-table1))
(define (get key-1 key-2) (lookup key-1 key-2 operation-table))
(define (put key-1 key-2 value) (insert key-1 key-2 value operation-table))

(define (make-table)
  (let ((local-table (mcons '*table* '())))
    (define(make-record key value)
      (mcons key value))
    (define (make-subtable key record-list)
      (mcons key record-list))
    (define (record-list subtable)
      (mcdr subtable))
    (define (same-key? key-1 key-2)
      (if (and (number? key-1)
               (number? key-2))
          (< (abs (- key-1 key-2)) 0.01)
          (equal? key-1 key-2)))
    
    #|(define (assoc key records)
      (cond
        ((null? records) #f)
        ((same-key? key (mcar (mcar records))) (mcar records))
        (else (assoc key (mcdr records)))))
    
    

    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (mcdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (mcdr subtable))))
              (if record
                  (mcdr record)
                  #f))
            #f)))

    (define (insert key-1 key-2 value)
      (let ((subtable (assoc key-1 (mcdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (mcdr subtable))))
              (if record
                  (set-mcdr! record value)
                  (set-mcdr! subtable
                             (mcons (make-record key-2 value)
                                    (record-list subtable)))))
            (set-mcdr! local-table
                       (mcons (make-subtable key-1
                                             (mcons (make-record key-2 value)
                                                    '()))
                              (mcdr local-table)))))
      'ok) |#
    (define (last-key? keys) (null? (cdr keys)))
    (define (get-value record) (mcdr record))
    (define (assoc key records)
      (cond
        ((null? records) #f)
        ((same-key? key (mcar (mcar records))) (mcar records))
        (else (assoc key (mcdr records)))))

    (define (lookup-record keys table)
        (if (null? keys)
            table
            (let ((subtable (assoc (car keys) table)))
                      (if subtable
                          (lookup-record (cdr keys) (mcdr subtable))
                          #f))))





    (define (lookup keys)
      (define (iter keys table)
        (if (null? keys)
            table
            (let ((subtable (assoc (car keys) table)))
              (if subtable
                  (iter (cdr keys) (mcdr subtable))
                  #f))))
      (if (null? keys)
          (error "lookup procedure no keys")
          (iter keys (mcdr local-table))))

    (define (insert keys value)
      (define (iter keys table)
        (if (null? keys)
            (set-mcdr! table value)
            (let ((record (assoc (car keys) (mcdr table))))
              (if record
                  (iter (cdr keys) record)
                  (begin
                    (set-mcdr! table (mcons (make-record (car keys) '())
                                          (mcdr table)))
                    (iter (cdr keys) (mcar (mcdr table))))
                    ))))
      (if (null? keys)
          (error "insert procedure with no keys")
          (iter keys local-table))
      'ok)
    
    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert) insert)
            (else (error "unknown operation: Table" m))))
    dispatch

    ))



(provide get put)


(define score (make-table))
((score 'insert) (list 'math 'geometry) 65)
((score 'insert) (list 'math 'algebra) 63)
((score 'insert) (list 'math 'geometry) 23)
((score 'lookup) (list 'math 'geometry))
((score 'lookup) (list 'math))

(define a 1)
(define b 2)
(define c (mcons a b))
(define d (mcons c 1))
(set-mcar! c 2)
(define e (mcar c))
;e
(set! e 10)
;c
