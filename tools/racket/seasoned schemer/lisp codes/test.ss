(define test2
  (lambda (x)
    (+ 3 1)))

(define test1
  (lambda (x)
    (+ (test2 32) x)))
(define test3
  (lambda (x)
    (+ (test1 1) x)))
