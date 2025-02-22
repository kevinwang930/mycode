#lang racket
;data-directed-programming of deriv

;(define *the-table* (make-hash));make THE table 
 ;(define (put key1 key2 value) (hash-set! *the-table* (list key1 key2) value));put 
 ;(define (get key1 key2) (hash-ref *the-table* (list key1 key2) #f));get
(require (only-in "../ch3-modularity/3-3-3-2-dimensional-table.rkt" get put))
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (make-sum  a1 a2)
  (cond
     ((and (number? a1) (number? a2)) (+ a1 a2))
     ((=number? a1 0) a2)
     ((=number? a2 0) a1)
      
     (else (list '+ a1 a2))))




(define (make-product m1  m2)
  (cond
    ((and (number? m1) (number? m2)) (* m1 m2))
    ((or (=number? m1 0) (=number? m2 0))
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        (else
         (list '* m1 m2))))


(define (make-exponentiation base exponent)
  (cond ((and (number? base) (number? exponent))
         (expt base exponent))
        ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        (else (list '** base exponent))))
;derivation function
(define (install-derivation-package)
  (define addend car)
  (define augend cadr)
  (define multiplier car)
  (define multiplicand cadr)
  (define base car)
  (define exponent cadr)
  
  (define (deriv-product operands var)
    (let  ((m1 (make-product (multiplier operands)
                           (deriv (multiplicand operands) var)))
           (m2  (make-product (multiplicand operands)
                            (deriv (multiplier operands) var))))
           (make-sum m1 m2)))
  
  (define (deriv-sum operands var)
    (make-sum (deriv (addend operands) var)
              (deriv (augend operands) var)))

  (define (deriv-exponent operands var)
    (if (same-variable? (base operands) var)
        (make-product (exponent operands) (make-exponentiation (base operands) (- (exponent operands) 1)))
        0))

  (put 'deriv '+
       deriv-sum)
  ;(put 'deriv '-)
  (put 'deriv '* deriv-product)
  ;(put 'deriv '/)
  (put 'deriv '** deriv-exponent)
  'done)

(define (make-hq-file divison-name record-file)
  (cons divison-name record-file))
(define (get-division hq-file)
  (car hq-file))
(define (get-file hq-file)
  (cdr hq-file))

(define (get-record employee hq-file)
  ((get 'get-record (get-division hq-file))
       employee (get-file hq-file)))

(define (has-record? employee division)
  ((get 'has-record? division) employee))

(define (get-salary employee division-file)
  (if (has-record? employee (get-division division-file))
      (let ((record (get-record employee division-file)))
        ((get 'get-salary (get-division division-file) record)))
      (error "no such person record" 'get-salary)))

(define (find-employee-record employee division-file-list)
  (define (find-employee-record-1 employee divison-file-list result)
    (if (null? division-file-list)
        result
        (let ((single-division-result (get-record employee (car division-file-list))))
          (if (null? single-division-result)
              (find-employee-record employee (cdr division-file-list))
              (find-employee-record employee (cons single-division-result result))))))
  (find-employee-record-1 employee division-file-list null))
  

;every division needs to put its record-function get-record, has-record? get-salary


;test
(install-derivation-package)
(deriv '(+ x 2) 'x)
(deriv '(+ (* 2 (** x 2)) 2) 'x)