#lang racket
(struct document (author title content))
(struct book document (publisher))
(struct paper (journal) #:super struct:document)

(define p1 (paper 'kevin 'test 'test 'jurnal))
 (struct constant-stream (val)
    #:methods gen:stream
    [(define (stream-empty? stream) #f)
     (define (stream-first stream)
       (constant-stream-val stream))
     (define (stream-rest stream) stream)])