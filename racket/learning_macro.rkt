#lang racket

;syntax transformer transfrom the input syntax into the output syntax
(define-syntax foo
  (lambda (stx)
  (syntax "I am fool")))
(define-syntax (also-foo stx)
  (syntax "I am fool"))
(define-syntax (quoted-foo stx)
  #'"I am fool")
(define-syntax (say-hi stx)
  #'(display "hi"))
;what is the input syntax
(define-syntax (show-me stx)
  (print stx)
  #'(void))

(define-syntax (reverse-me stx)
    (datum->syntax stx (reverse (cdr (syntax->datum stx)))))


;implement if with transformer binding
(define (our-if condition true-expr false-expr)
  (cond (condition true-expr)
        (else false-expr)))
(define (display-and-return x)
  (our-if-v2 x
        (displayln "true")
        (displayln "false")))

(define-syntax (our-if-v2 stx)
  (define xs (syntax->list stx))
  (datum->syntax stx `(cond [,(cadr xs) ,(caddr xs)]
                            [else ,(cadddr xs)])))

; define if using syntax case
(define-syntax (our-if-v3 stx)
  (syntax-case stx ()
    [(_ condition true-expr false-expr)
     #'(cond [condition true-expr]
             [else false-expr])]))

(our-if-v3 #t
        (display-and-return "true")
        (display-and-return "false"))

  ;(datum->syntax stx (cons )))
;test
(define-syntax (apply stx)
  (syntax-case stx ()
    [(_ f `(args ...))
     #'(f args ...)]
    [(_ f (list args ...))
     #'(f args ...)]))
;(foo)
;(also-foo)
;(quoted-foo)
;(say-hi)
;(show-me '(+ 1 2))
(apply + (list 1 2))
(reverse-me "backward" "am" "I" values)
(reverse-me 1 2 3 +)
(datum->syntax #f '(values "i" "am" "backwards"))
(display-and-return #t)