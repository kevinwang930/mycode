#lang racket/base
(require rackunit "3-3-2-queue-FIFO.rkt")

(define q (make-queue))
(insert-queue! q 1)
(insert-queue! q 2)
