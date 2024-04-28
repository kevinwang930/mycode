#lang racket
(require "../basic_function.rkt")
;symbolic data
;quotation mark to indicate that a word or sentence is to be treated
;literally as a string of characters.
;meaning of quote character is to quote the next object.
;single quote can be used to denote list or symbols
;double quote is used only with character strings.

(define a 1)
(define b 2)

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))
;(eq? (list a b 'c) (list 1 2 'c))    ;2 list not the same
;(equal? (list a b 'c) (list 1 2 'c)) ;2 lists is equal if they contain
;equal elements in same order；
;example: symbolic differentiation
;differentiation program with abstract data
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (let  ((m1 (make-product (multiplier exp)
                                 (deriv (multiplicand exp) var)))
                 (m2  (make-product (multiplicand exp)
                                 (deriv (multiplier exp) var))))
           (make-sum m1 m2)))
        ((exponentiation? exp)
         (if (same-variable? (base exp) var)
             (make-product (exponent exp) (make-exponentiation (base exp) (- (exponent exp) 1)))
             0))
        (else
         (error "unkown expression type : Deriv" exp))))

;representing algebraic expressions;
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
#;(define (make-sum a1 a2)
  (list '+ a1 a2))
#;(define (make-product m1 m2)
  (list '* m1 m2))
; prefix operators, ordinary mathematical notation
#|
(define (sum? x)
  (eq? (car x) '+))
(define (addend s)
  (cadr s))
(define (augend s)
  (let ((augends (cddr s)))
    (cond ((null? augends) 0)
          ((= (length augends) 1) (car augends))
          (else (apply make-sum augends)))))
(define (product? x)
  (eq? (car x) '*))
(define (multiplier s)
  (cadr s))
(define (multiplicand s)
  (cond ((= (length s) 3) (caddr s))
        (else (cons '* (cddr s)))))
;modifiy make-sum constructor to reduce the result to simplest form
(define (make-sum . a)
  (let ((nums (apply + (number-arguments a)))
        (non-nums (non-number-arguments a)))
    (cond
      ((null? non-nums) nums)
      ((=number? nums 0)
       (if (= (length non-nums) 1)
           (car non-nums)
           (cons '+ non-nums)))
      (else (list '+ (append  non-nums nums))))))



(define (make-product m1 m2 . m-list)
  (cond ((null? m-list) (make-product-2 m1 m2))
        (else (make-product-2 m1 (accumulate make-product-2 m2 m-list)))))
(define (make-product-2 m1  m2)
  (cond ((or (=number? m1 0) (=number? m2 0))
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        (else
         (list '* m1 m2))))

|#

; infix operator
;predicator?

(define (infix-op s)
  (cadr s))
(define (sum? x)
  (eq? (infix-op x) '+))
(define (product? x)
  (eq? (infix-op x) '*))

;selector
(define (addend s)
  (car s))
(define (augend s)
  (let ((augends (cddr s)))
    (let ((augends-length (length augends)))
      (cond ((= augends-length 0) 0)
            ((= augends-length 1) (car augends))
            (else augends)))))


(define (multiplier s)
  (car s))
(define (multiplicand s)
  (let ((multiplicands (cddr s)))
    (let ((multiplicands-length (length multiplicands)))
      (cond ((= multiplicands-length 0) 0)
            ((= multiplicands-length 1) (car multiplicands))
            (else multiplicands)))))
;consturctor
;modifiy make-sum constructor to reduce the result to simplest form
(define (make-sum  a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (+ a1 a2))
      ((=number? a1 0) a2)
      ((=number? a2 0) a1)
      
      (else (list a1 '+ a2))))
(define (make-product m1  m2)
  (cond
    ((and (number? m1) (number? m2)) (* m1 m2))
    ((or (=number? m1 0) (=number? m2 0))
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        (else
         (list '* m1 m2))))

(define (number-arguments s)
  (filter number? s))
(define (non-number-arguments s)
  (filter (lambda (e)
            (not (number? e))) s))


(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (make-exponentiation base exponent)
  (cond ((and (number? base) (number? exponent))
         (expt base exponent))
        ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        (else (list '** base exponent))))
(define (exponentiation? exp)
  (and (list? exp)
       (eq? (car exp) '**)))

(define (base s)
  (cadr s))
(define (exponent s)
  (caddr s))




;test
;(car '(** x 2))
;(eq? (car '(** x 2)) '*)
(deriv '(3 + 2 * 4 * x) 'x)
(deriv '(x + 3 * (x + y + (2 * x * x))) 'x)
;(deriv '(x + 3 * (x + y + 2)) 'x)
;(deriv '(* 3 (** x 2)) 'x)
;(deriv '(+ (* 3 (** x 2)) (* 4 x)) 'x)
;(deriv '(+ (* 2 x) 3) 'x)
;(deriv (make-product 'x 'y '(+ x 3)) 'x)

;(car ''abracadabra)

;(a 2)
;(b 1)
;(list a b)
;(a b)
;(list 'a b)
;(car '(a b c))
;(cdr '(a b c))


#|(memq 'a '(a b c))
(memq 1 '(1 2 3))
(memq 'apple '((apple tree) apple sweet))

;(car '(a b c))
(list 'a 'b 'c)
(list (list 'george))
(cdr '((x1 x2) (y1 y2)))
(cadr '((x1 x2) (y1 y2)))
(pair? (car '(a short list)))
(memq 'red '((red shoes) (blue socks)))
(memq 'red '(red shoes blue socks))

|#

