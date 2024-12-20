#lang racket
(require "ch2support.rkt")
(require "../basic_function.rkt")
;(require "Complex_number_representation.rkt")
;(require "representation_for_complex_numbers.rkt")


(define *the-table* (make-hash));make THE table 
(define (put key1 key2 value) (hash-set! *the-table* (list key1 key2) value));put 
(define (get key1 key2) (hash-ref *the-table* (list key1 key2) #f));get

(define (make-entry k v) (list k v))
(define (key entry) (car entry))
(define (value entry) (cadr entry))

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

;rectangular and polar package
(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt ( + (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'zero? '(rectangular) (lambda (x)
                               (and (= (real-part x) 0)
                                    (= (imag-part x) 0))))
  (put 'equ? '(rectangular rectangular)
       (lambda (x y)
          (and (equ? (real-part x) (real-part y))
               (equ? (imag-part x) (imag-part y)))))
  'done)

(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z) (* (magnitude z) (cos (angle z))))
  (define (imag-part z) (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'zero? '(polar) (lambda (x) (= (magnitude x) 0)))
  (put 'equ? '(polar polar) (lambda (x y)
                              (and (equ? (magnitude x) (magnitude y))
                                   (equ? (angle x) (angle y)))))
  'done)






;primitive number package 
#;(define (install-scheme-number-package)
    (define (tag x) (attach-tag 'scheme-number x))
    (put 'add '(scheme-number scheme-number)
         (lambda (x y) (tag (+ x y))))
    (put 'sub '(scheme-number scheme-number)
         (lambda (x y) (tag (- x y))))
    (put 'mul '(scheme-number scheme-number)
         (lambda (x y) (tag (* x y))))
    (put 'div '(scheme-number scheme-number)
         (lambda (x y) (tag (/ x y))))
    (put 'make 'scheme-number (lambda (x) (tag x)))
    (put '=zero? '(scheme-number) (lambda (x) (= x 0)))
    'done)

;constructor of scheme number
#;(define (make-scheme-number n)
    ((get 'make 'scheme-number) n))

(define (install-integer-package)
  (define (tag x) (attach-tag 'integer x))
  (put 'add '(integer integer)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(integer integer)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(integer integer)
       (lambda (x y) (tag (* x y))))
  (put 'div '(integer integer)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'integer (lambda (x) (tag x)))
  (put 'equ? '(integer integer) =)
  (put '=zero? '(integer) (lambda (x) (= x 0)))
  (put 'raise '(integer) (lambda (x) (make-rational x 1)))
  (put 'project '(integer) identity)
  'done)

;constructor of intger number
(define (make-integer n)
  ((get 'make 'integer) n))


;rational number package
(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (if (= d 0)
        (error 'make-rational "denominator is zero")
        (let ((g (gcd n d)))
          (cons (/ n g) (/ d g)))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  (define (rational->complex x)
    (make-complex-from-real-imag (tag x) 0))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  (put '=zero? '(rational) (lambda (x) (= (numer x) 0)))
  (put 'equ? '(rational rational) (lambda (x y)
                                    (and (= (numer x) (numer y))
                                         (= (denom x) (denom y)))))
  (put 'raise '(rational) rational->complex)
  (put 'project '(rational) (lambda (x) (quotient (numer x) (denom x))))
  'done)

;rational number constructor
(define (make-rational n d)
  ((get 'make 'rational) n d))


;complex number package
(define (install-complex-package)
  (install-rectangular-package)
  (install-polar-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (real-part z) (apply-generic 'real-part z))
  (define (imag-part z) (apply-generic 'imag-part z))
  (define (magnitude z) (apply-generic 'magnitude z))
  (define (angle z) (apply-generic 'angle z))
  (define (zero? z) (apply-generic 'zero? z))
  (define (add-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))
  (define (equ-complex z1 z2) (and (equ? (magnitude z1) (magnitude z2))
                                 (equ? (angle z1) (angle z2))))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  (put '=zero? '(complex) zero?)
  (put 'project '(complex) real-part)
  (put 'equ? '(complex complex) equ?)
  (put 'equ? '(rectangular polar) equ-complex)
  (put 'equ? '(polar rectangular) equ-complex)
  'done)
;complex number constructor
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))
(define (magnitude complex-number)
  (apply-generic 'magnitude complex-number))
(define (angle complex-number)
  (apply-generic 'angle complex-number))
(define (real-part complex-number)
  (apply-generic 'real-part complex-number))
(define (imag-part complex-number)
  (apply-generic 'imag-part complex-number))


;coercion procedure to transfrom one type of data to another type
;set up coercion table, modify the apply-generic first check operation-type table
;if can not find suitable procedure, then check coercion table.


(define coercion-array '())
(define (put-coercion lhs_type rhs_type function)
  (define (put-helper k array)
    (cond ((null? array) (list (make-entry k function)))
          ((equal? (key (car array)) k) array)
          (else (cons (car array) (put-helper k (cdr array))))))
  (set! coercion-array (put-helper (list lhs_type rhs_type) coercion-array)))

(define (get-coercion lhs_type rhs_type)
  (define (get-helper k array)
    (cond ((null? array) #f)
          ((equal? (key (car array)) k) (value (car array)))
          (else (get-helper k (cdr array)))))
  (get-helper (list lhs_type rhs_type) coercion-array))

;install coercion table
(define (install-coercion-table)
  (define (integer->rational n)
    (make-rational n 1))
  (define (integer->complex n)
    (make-complex-from-real-imag n 0))
  (define (rational->complex n)
    (make-complex-from-real-imag n 0))
  (put-coercion 'integer
                'complex
                integer->complex)
  (put-coercion 'rational
                'complex
                rational->complex)
  (put-coercion 'integer
                'rational
                integer->rational)
  'done)

(define (install-type-level)
  (put 'type-level '(integer) (lambda (x) 1))
  (put 'type-level '(rational) (lambda (x) 2))
  (put 'type-level '(complex) (lambda (x) 3))
  (put 'type-level '(polynomial) (lambda (x) 4)))

(define (same-types? types)
  (define (same-first-types? first types)
    (cond ((null? types) #t)
          ((eq? first (car types)) (same-first-types? first (cdr types)))
          (else #f)))
  (same-first-types? (car types) (cdr types)))

;apply-generic with coercion version
#;(define (apply-generic op . args)
   
    (define (all-coercable? coerce-procs)
      (not (member #f coerce-procs)))
  
    (define (coerce-args coercion-procs args)
      (map (lambda (coerce-proc arg) 
             (coerce-proc arg))
           coercion-procs
           args))
   
    ; attempt to coerce all args into a common type among the args
    (define (apply-with-coercion arg-types)
     
      ; attempt to coerce all args using each tag-type in turn
      ; it's a scoped procedure to keep the original arguments (arg-types) for error reporting
      (define (coerce-types tags)
        (if (null? tags)   ; all targets exhausted 
            (error "No method for these types - APPLY-GENERIC"
                   (list op arg-types))
            (let* ((target-type (car tags))
                   (arg-coercions (map        ; get all the coercion procedures from the target 
                                   (lambda (coerce-from) 
                                     (if (eq? coerce-from target-type)
                                         identity
                                         (get-coercion coerce-from target-type)))
                                   arg-types))) 
              (if (all-coercable? arg-coercions) 
                  ; the target type is valid if all the args can be coerced 
                  (apply apply-generic  
                         op 
                         (coerce-args arg-coercions args))
                  ; target-type is not valid, so try the next one in the list
                  (coerce-types (cdr tags))))))        ; try the next target type
     
      (coerce-types arg-types))
   
    (let* ((type-tags (map type-tag args))
           (proc (get op type-tags)))
      (if proc 
          (apply proc (map contents args))
          (cond ((< (length type-tags) 2) (error "No method for this type - APPLY-GENERIC"
                                                 (list op type-tags)))
                ((same-types? type-tags) (error "No method for this type - APPLY-GENERIC"
                                                (list op type-tags)))
                (else (apply-with-coercion type-tags))))))

;apply-generic with raise version
(define (apply-generic op . args)
   
 
  
  (define (raise-args target-level args)
    (map (lambda (arg)
           (raise-arg target-level arg))
         args))
  (define (raise-arg target-level arg)
    (let ((level (type-level arg)))
      (cond ((< level target-level)
             (raise-arg target-level (raise arg)))
            ((= level target-level) arg)
            (else #f))))
  (define (highest-level args)
    (if (null? args)
        0
        (let ((level (type-level (car args)))
              (highest (highest-level (cdr args))))
          (if (< level highest)
              highest
              level)))) 
 
  (define (apply-with-raise arg-types args)
    ;find highest level of argument,
    ;then raise all arguments of the lower level to highest
    (let ((highest (highest-level args)))
      (apply apply-generic  
             op 
             (raise-args highest args))))
                
   
  (let* ((type-tags (map type-tag args))
         (proc (get op type-tags)))
    (if proc 
        (apply proc (map contents args))
        (cond ((< (length type-tags) 2) (error "No method for this type - APPLY-GENERIC"
                                               (list op type-tags)))
              ((same-types? type-tags) (error "No method for this type - APPLY-GENERIC"
                                              (list op type-tags)))
              (else (apply-with-raise type-tags args))))))

;generic arithmetic procedure
(define (add x y) (drop (apply-generic 'add x y)))
(define (sub x y) (drop (apply-generic 'sub x y)))
(define (mul x y) (drop (apply-generic 'mul x y)))
(define (div x y) (drop (apply-generic 'div x y)))
(define (equ? x y) (apply-generic 'equ? x y))
(define (=zero? x) (apply-generic '=zero? x))
(define (raise arg)
  (apply-generic 'raise arg))
(define (type-level z) (apply-generic 'type-level z))
(define (project z) (apply-generic 'project z))
;hierarchy of types




;(install-complex-package)
;(install-rational-package)
;(install-integer-package)
;(install-coercion-table)
;(install-type-level)

(define (drop x)
  (cond ((= (type-level x) 1) x)
        ((= (type-level x) 4) x)
        (else
         (let* ((project-x (project x))
             (project-raise-x (raise project-x)))
           (if (equ? project-raise-x x)
               project-x
               x)))))

;test
#|
(define p1 (make-complex-from-real-imag 2 3))
(define p2 (make-complex-from-real-imag 5 1))
(define r1 (make-rational 2 1))

(add 2 p2)
(add r1 p1)
(sub (make-rational 1 3) (make-rational 2 6))
(project p2)
(drop r1)
|#

(provide (all-defined-out)
         (all-from-out "ch2support.rkt"))













