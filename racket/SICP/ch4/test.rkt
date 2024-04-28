#lang racket
(define (accumulate-plus x)
  (let ((sum 0))
    (for ([i (range (+ x 1))])
      (set! sum (+ sum i)))
    sum))


(define (a-plus x)
  (if (= x 0)
      0
      (+ x (a-plus (- x 1)))))

(define (b-plus x)
  (define (iter s c)
    (if (= c 0)
        s
        (iter (+ s c) (- c 1))))
  (iter 0 10))

(a-plus 10)
(b-plus 10)
(accumulate-plus 10)
(map car (list '(1 2 3) '(1 2 3)))
(map cons '(1 2 3) '(1 2 3))


(for ((i (range 10)))
  i)

(let ((a 1))
  (define define-test 1)
  a)

(define a (mcons 1 1))
(define b (mcons 1 1))
(define c (cons a b))
(define (eval x c)
  (set-mcar! (car c) x))
(eval 2 c)
(define (handle-test x)
  (if (> x 1)
      (raise 1)
      1))
(let ((a 1))
  (if (= a 1)
      (let ((a 2))
        a)
      a))
(let ((a 1))
  (define (f x)
    
    (define b (+ a x))
    (set! a 5)
    (+ a b))
  (f 10))

(define (make-seqs . a)
  a)
(make-seqs 1)

(define (av x) (values (+ x 1) (+ x 2)))
(let-values ([(ta tb) (av 2)])
  (list ta tb))


(define Y (lambda (b) ((lambda (f) (b (lambda (x) ((f f) x))))
                  (lambda (f) (b (lambda (x) ((f f) x)))))))
(define Fact
  (Y (λ (fact) (λ (n) (if (zero? n) 1 (* n (fact (- n 1))))))))

(Fact 3)
