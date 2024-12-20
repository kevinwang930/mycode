#lang racket


(define atom? 
(lambda (x) 
(and (not (pair? x))  (not (null? x)))))


(define add1
  (lambda (n)
    (+ n 1)))
;(add1 46)
(define sub1
  (lambda (n)
    (- n 1)))
(define o+
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (o+ (add1 n) (sub1 m))))))

(define o-
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (o- (sub1 n) (sub1 m))))))

(define o>
  (lambda (n m)
    (cond
      ((and (zero? m) (zero? n)) #f)
      ((zero? n) #f)
      ((zero? m) #t)
      (else (o> (sub1 n) (sub1 m))))))

(define o<
  (lambda (n m)
    (cond
      ((and (zero? m) (zero? n)) #f)
      ((zero? m) #f)
      ((zero? n) #t)
      (else (o< (sub1 n) (sub1 m))))))

(define o=
  (lambda (n m)
    (cond
      ((and (zero? m) (zero? n)) #t)
      ((zero? m) #f)
      ((zero? n) #f)
      (else (o= (sub1 n) (sub1 m))))))
;(o< 1 2)
;(o= 34 34)

(define o^
  (lambda (n m)
    (cond
      ((o= m 0) 1)
      (else (o* n
                (o^ n (sub1 m)))))))
;(o^ 2 3)

(define o/
  (lambda (n m)
    (cond
      ((o< n m) 0)
      (else (add1 (o/ (- n m) m))))))

(define o*
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else (o+ n
                (o* n (sub1 m)))))))


(define define?
  (lambda (e)
    (cond
      ((atom? e) #f)
      ((atom? (car e)) (eq? (car e) (quote define)))
      (else #f))))

(define lookup
  (lambda (table name)
    (table name)))

(define *define
  (lambda (e)
    (set! global-table (extend (name-of e)
                               (box
                                (the-meaning (right-side-of e)))
                               global-table))))

(define box
  (lambda (it)
    (lambda (sel)
      (sel it (lambda (new)
                (set! it new))))))

(define setbox
  (lambda (box new)
    (box (lambda (it set) (set new)))))

(define unbox
  (lambda (box)
    (box (lambda (it set) it))))


(define the-meaning
  (lambda (e)
    (meaning e look-up-in-global-table)))

(define look-up-in-global-table
  (lambda (name)
    (lookup global-table name)))

(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))

(define *quote
  (lambda (e table)
    (text-of e)))

(define *identifier
  (lambda (e table)
    (unbox (lookup table e))))

(define *set
  (lambda (e table)
    (setbox
     (lookup table (name-of e))
     (meaning (right-side-of e) table))))

(define *lambda
  (lambda (e table)
    (lambda (args)
      (beglis (body-of e)
              (multi-extend
               (formals-of e)
               (box-all args)
               table)))))

(define beglis
  (lambda (es table)
    (cond
      ((null? (cdr es)) (meaning (car es) table))
      (else ((lambda (val)
               (beglis (cdr es) table))
             (meaning (car es) table))))))

(define box-all
  (lambda (vals)
    (cond
      ((null? vals) (quote ()))
      (else (cons (box (car vals))
                  (box-all (cdr vals)))))))

(define multi-extend
  (lambda (names values table)
    (cond
      ((null? names) table)
      (else
       (extend (car names) (car values)
               (multi-extend
                (cdr names)
                (cdr values)
                table))))))

(define odd?
  (lambda (n)
    (cond
      ((zero? n) #f)
      (else (even? (sub1 n))))))

(define even?
  (lambda (n)
    (cond
      ((zero? n) #t)
      (else (odd? (sub1 n))))))

(define extend
  (lambda (name1 value table)
    (lambda (name2)
      (cond
        ((eq? name1 name2) value)
        (else (table name2))))))

(define *application
  (lambda (e table)
    ((meaning (function-of e) table)
     (evlis (arguments-of e) table))))

(define evlis
  (lambda (args table)
    (cond
      ((null? args) (quote ()))
      (else
       ((lambda (val)
          (cons val
                (evlis (cdr args) table)))
        (meaning (car args) table))))))

(define :car
  (lambda (args-in-a-list)
    (car (car args-in-a-list))))

(define a-prim
  (lambda (p)
    (lambda (args-in-a-list)
      (p args-in-a-list))))

(define b-prim
  (lambda (p)
    (lambda (args-in-a-list)
      (p (car args-in-a-list)
         (car (cdr args-in-a-list))))))

(define *const1
  (lambda (e table)
    (cond
      ((number? e) e)
      ((eq? e #t) #t)
      ((eq? e #f) #f)
      ((eq? e (quote cons)) (b-prim cons))
      ((eq? e (quote car)) (a-prim car))
      ((eq? e (quote cdr)) (a-prim cdr))
      ((eq? e (quote eq?)) (b-prim eq?))
      ((eq? e (quote atom?)) (a-prim atom?))
      ((eq? e (quote null?)) (a-prim null?))
      ((eq? e (quote zero?)) (a-prim zero?))
      ((eq? e (quote add1)) (a-prim add1))
      ((eq? e (quote sub1)) (a-prim sub1))
      ((eq? e (quote number?)) (a-prim number?)))))

(define *constl
  ((lambda (:cons :car :cdr :eq? :atom? :null? :zero? :add1 :sub1 :number?)
     (lambda (e table)
       (cond
         ((number? e) e)
      ((eq? e #t) #t)
      ((eq? e #f) #f)
      ((eq? e (quote cons)) :cons)
      ((eq? e (quote car)) :car)
      ((eq? e (quote cdr)) :cdr)
      ((eq? e (quote eq?)) :eq?)
      ((eq? e (quote atom?)) :atom?)
      ((eq? e (quote null?)) :null?)
      ((eq? e (quote zero?)) :zero?)
      ((eq? e (quote add1)) :add1)
      ((eq? e (quote sub1)) :sub1)
      ((eq? e (quote number?)) :number?))))
   (b-prim cons)
   (a-prim car)
   (a-prim cdr)
   (b-prim eq?)
   (a-prim atom?)
   (a-prim null?)
   (a-prim zero?)
   (a-prim add1)
   (a-prim sub1)
   (a-prim number?)))

(define *const
  (let ((:cons (b-prim cons))
        (:car (a-prim car))
        (:cdr (a-prim cdr))
        (:eq? (b-prim eq?))
        (:atom? (a-prim atom?))
        (:null? (a-prim null?))
        (:zero? (a-prim zero?))
        (:add1 (a-prim add1))
        (:sub1 (a-prim sub1))
        (:number? (a-prim number?)))
    (lambda (e table)
      (cond
         ((number? e) e)
         ((eq? e #t) #t)
         ((eq? e #f) #f)
         ((eq? e (quote cons)) :cons)
         ((eq? e (quote car)) :car)
         ((eq? e (quote cdr)) :cdr)
         ((eq? e (quote eq?)) :eq?)
         ((eq? e (quote atom?)) :atom?)
         ((eq? e (quote null?)) :null?)
         ((eq? e (quote zero?)) :zero?)
         ((eq? e (quote add1)) :add1)
         ((eq? e (quote sub1)) :sub1)
         ((eq? e (quote number?)) :number?)))))

(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)))

(define evcon
  (lambda (lines table)
    (cond
      ((else? (question-of (car lines)))
       (meaning (answer-of (car lines)) table))
      ((meaning (question-of (car lines)) table)
       (meaning (answer-of (car lines)) table))
      (else (evcon (cdr lines) table)))))

(define *letcc
  (lambda (e table)
    (let/cc skip
      (beglis (ccbody-of e)
              (extend
               (name-of e)
               (box (a-prim skip))
               table)))))

(define value
  (lambda (e)
    (let/cc the-end
      (set! abort the-end)
      (cond
        ((define? e) (*define e))
        (else (the-meaning e))))))

(define abort (lambda (x) x))

(define the-empty-table
  (lambda (name)
    (abort
     (cons (quote no-answer)
           (cons name (quote ()))))))

(define expression-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else (list-to-action e)))))

(define atom-to-action
  (lambda (e)
    (cond
      ((number? e) *const)
      ((eq? e #t) #t)
      ((eq? e #f) #f)
      ((eq? e (quote cons)) *const)
      ((eq? e (quote car)) *const)
      ((eq? e (quote cdr)) *const)
      ((eq? e (quote null?)) *const)
      ((eq? e (quote eq?)) *const)
      ((eq? e (quote atom?)) *const)
      ((eq? e (quote zero?)) *const)
      ((eq? e (quote add1)) *const)
      ((eq? e (quote sub1)) *const)
      ((eq? e (quote number?)) *const)
      (else *identifier))))

(define list-to-action
  (lambda (e)
    (cond
      ((atom? (car e))
       (cond
         ((eq? (car e) (quote quote)) *quote)
         ((eq? (car e) (quote lambda)) *lambda)
         ((eq? (car e) (quote letcc)) *letcc)
         ((eq? (car e) (quote set!)) *set)
         ((eq? (car e) (quote cond)) *cond)
         (else *application)))
      (else *application))))

(define text-of
  (lambda (x)
    (car (cdr x))))

(define formals-of
  (lambda (x)
    (car (cdr x))))

(define body-of
  (lambda (x)
    (cdr (cdr x))))

(define ccbody-of
  (lambda (x)
    (cdr (cdr x))))

(define name-of
  (lambda (x)
    (car (cdr x))))

(define right-side-of
  (lambda (x)
    (cond
      ((null? (cdr (cdr x))) 0)
      (else (car (cdr (cdr x)))))))

(define cond-lines-of
  (lambda (x)
    (cdr x)))

(define else?
  (lambda (x)
    (cond
      ((atom? x) (eq? x (quote else)))
      (else #f))))

(define question-of
  (lambda (x)
    (car x)))
(define answer-of
  (lambda (x)
    (car (cdr x))))

(define function-of
  (lambda (x)
    (car x)))

(define arguments-of
  (lambda (x)
    (cdr x)))


(define global-table (lambda (x y) (x y)))


(value (add1 1))


































