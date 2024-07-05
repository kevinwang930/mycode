#lang racket
;(require for-syntax racket)
#;(define-syntax (bar syntax-object)
    (syntax-case syntax-object ()
      ((_ a ...)
       #'(printf "~a\n" (list a ...)))))

;(bar 3 4 5)

(define-syntax (hello stx)
    (syntax-case stx ()
      [(_ name place)
       (with-syntax ([print-name #'(printf "~a\n" 'name)]
                     [print-place #'(printf "~a\n" 'place)])
         #'(begin
             (define (name times)
               (printf "Hello\n")
               (for ([i (in-range 0 times)])
                    print-name))
             (define (place times)
               (printf "From\n")
               (for ([i (in-range 0 times)])
                    print-place))))]))

(hello kevin Henan)
(Henan 3)

(kevin 3)

#;(define-syntaxes (or-unsafe)
    (lambda (stx)
      (let-values ([(es) (cdr (syntax-e stx))])
        (let-values ([(e) (car (if (syntax? es)
                                   (syntax-e es)
                                   es))])
          (datum->syntax #f
                         (list (quote-syntax if)
                               (quote-syntax (variable-reference-from-unsafe? (#%variable-reference)))
                               (quote-syntax #t)
                               e))))))

(define-syntax (apply stx)
    (syntax-case stx ()
      [(a f ls) 
       #'(cons f ls)
       
                  #;(datum->syntax  stx
                                  ('cons (syntax-e f)
                                         (syntax->datum ls)))
                  ]))
(define-syntax m
  (syntax-rules ()
    [(_ id) (define id 5)]))
(m x)
x
(define map2
      (let ([map
             (case-lambda
              [(f l)
               (if (and (procedure? f)
                        (procedure-arity-includes? f 1)
                        (list? l))
                   (let loop ([l l])
                     (cond
                      [(null? l) null]
                      [else
                       (let ([r (cdr l)]) ; so `l` is not necessarily retained during `f`
                         (cons (f (car l)) (loop r)))]))
                   (display "or-unsafe #f"))]
                   ;(gen-map f (list l)))]
              [(f l1 l2)
               (if (and (procedure? f)
                         (procedure-arity-includes? f 2)
                         (list? l1)
                         (list? l2)
                         (= (length l1) (length l2)))
                   (let loop ([l1 l1] [l2 l2])
                     (cond
                      [(null? l1) null]
                      [else 
                       (let ([r1 (cdr l1)]
                             [r2 (cdr l2)])
                         (cons (f (car l1) (car l2)) 
                               (loop r1 r2)))]))
                   (display "error"))]
                   ;(gen-map f (list l1 l2)))]
              [(f l . args) (gen-map f (cons l args))]
              )])
        map))
(define (gen-map f ls)
    ;(or-unsafe (check-args 'map f ls))
    (let loop ([ls ls])
      (cond
        [(null? (car ls)) null]
        [else
         (let ([next-ls (map2 cdr ls)])
           (cons (apply f (map2 car ls))
                 (loop next-ls)))])))
;(map2 (lambda (x) (+ x 1)) '(1 2 3))
;(or-unsafe '(1 2 3))
(define l1 '(1 2 3))
(define l2 '(1 2 3))
(define l3 '(1 2 3))
;(map2 + l1 l2 l3)
(define car-list (map2 car (list l1 l2 l3)))
;(cdr (syntax-e #'(+ (list 2 3))))

;(apply + '(1 2 3))
