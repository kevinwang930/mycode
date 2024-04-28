#lang racket
(define apply
  (let ()
    (define-syntax build-apply
      (lambda (x)
        (syntax-case x ()
          [(_ () cl ...)
           #'(case-lambda
               [(p r)
                (unless (procedure? p)
                  ($oops #f "attempt to apply non-procedure ~s" p))
                (let ([n ($list-length r 'apply)])
                  (case n
                    [(0) (p)]
                    [(1) (p (car r))]
                    [(2) (p (car r) (cadr r))]
                    [(3) (let ([y1 (cdr r)]) (p (car r) (car y1) (cadr y1)))]
                    [else ($apply p n r)]))]
               cl ...
               [(p x . r)
                (unless (procedure? p)
                   ($oops #f "attempt to apply non-procedure ~s" p))
                (let ([r (cons x ($apply list* ($list-length r 'apply) r))])
                   ($apply p ($list-length r 'apply) r))])]
          [(_ (s1 s2 ...) cl ...)
           (with-syntax ((m (length #'(s1 s2 ...))))
             #'(build-apply
                 (s2 ...)
                 [(p s1 s2 ... r)
                  (unless (procedure? p)
                    ($oops #f "attempt to apply non-procedure ~s" p))
                  (let ([n ($list-length r 'apply)])
                    (case n
                      [(0) (p s1 s2 ...)]
                      [(1) (p s1 s2 ... (car r))]
                      [(2) (p s1 s2 ... (car r) (cadr r))]
                      [(3) (let ([y1 (cdr r)])
                              (p s1 s2 ... (car r) (car y1) (cadr y1)))]
                      [else ($apply p (fx+ n m) (list* s1 s2 ... r))]))]
                 cl ...))])))
(build-apply (x1 x2 x3 x4))))