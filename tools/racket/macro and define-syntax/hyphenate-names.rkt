#lang racket

(require (for-syntax racket/syntax))

(define-syntax (hyphen-define/wrong1 stx)
  (syntax-case stx ()
    [(_ a b (args ...) body0 body ...)
     (let ([name1 (string->symbol (format "~a-~a" #`a #'b))])

       #'(define (name args ...)
           body0 body ...))]))

(define-syntax (hyphen-define/ok1 stx)
  (syntax-case stx ()
    [(_ a b (args ...) body0 body ...)
     (syntax-case (datum->syntax #'a
                                 (string->symbol (format "~a-~a"
                                                         (syntax->datum #'a)
                                                         (syntax->datum #'b))))
       ()
       [name #'(define (name args ...)
                 body0 body ...)])]))

;using with-syntax instead of syntax-case
(define-syntax (hyphen-define stx)
  (syntax-case stx ()
    [(_ a b (args ...) body0 body ...)
     (with-syntax ([name (datum->syntax #'a
                                 (string->symbol (format "~a-~a"
                                                         (syntax->datum #'a)
                                                         (syntax->datum #'b))))])
       
        #'(define (name args ...)
                 body0 body ...))]))



(define-syntax (foo stx)
    (syntax-case stx ()
      [(_ a)
        (with-syntax* ([b #'a]
                       [c #'b])
          #'c)]))

;test

(hyphen-define foo bar () #t)
(foo-bar)
(foo 3)


