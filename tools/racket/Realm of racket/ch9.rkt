#lang racket
(for ([i '(1 2 3 4 5)])
  (display (/ 1 i)))
(for/list ([i '(1 2 3 4 5)])
  (/ 1 i))
(map (lambda (x) (/ 1 x)) '(1 2 3 4 5))
(define-values (x y)
  (if (eq? 1 2)
      (values 10 20)
      (values 42 55)))
(for/list ([i '(1 2 3 4 5)]
           #:when (odd? i))
  i)
(for/fold ([sum 0])
          ([i '(1 2 3 4 5)]
           #:when (even? i))
  (+ sum i))

(for*/list ([k '((1 2) (3 4) (5 6) (7 8))]
            [n k])
  n)
(for/list ([i (in-range 10)])
  i)
