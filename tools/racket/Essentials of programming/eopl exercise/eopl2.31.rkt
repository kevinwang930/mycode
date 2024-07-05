#lang eopl

;Prefix-list ::= (Prefix-exp)
; Prefix-exp ::= Int
;            ::= - Prefix-exp Prefix-exp

(define-datatype prefix-exp prefix-exp?
  (const-exp (num integer?))
  (diff-exp (operand1 prefix-exp?)
            (operand2 prefix-exp?)))
(define parse-prefix-exp
  (lambda (list)
    (if (null? list)
        (report-error "prefix list" list)
        (let* ((Exp_with_after (first_exp_with_after list))
               (Exp (car Exp_with_after))
               (After_exp (cdr Exp_with_after)))
          (if (null? After_exp)
              Exp
              (report-error "valid prefix-list:integer or prefix with 2 operand" list))))))

(define first_exp_with_after
  (lambda (lst)
    (let ((element1 (car lst)))
      (if (integer? element1)
          (cons (const-exp element1)
                (cdr lst))
          (if (prefix? element1)
              (let* ((After-prefix (cdr lst)))
                (if (null? After-prefix)
                    (report-error "oprand after prefix" After-prefix)
                    (let*  ((Operand1_with_after (first_exp_with_after After-prefix))
                            (Operand1 (car Operand1_with_after))
                            (After-operand1 (cdr Operand1_with_after)))
                      (if (null? After-operand1)
                          (report-error "operand2 after operand1" After-operand1)
                          (let* ((Operand2_with_after (first_exp_with_after After-operand1))
                                 (Operand2 (car Operand2_with_after))
                                 (After-operand2 (cdr Operand2_with_after)))
                            (cons (diff-exp Operand1 Operand2)
                                  After-operand2))))))
              (report-error "integer or prefix expression" element1))))))

(define prefix?
  (lambda (var)
    (eq? var '-)))

(define report-error
  (lambda (expected datum)
    (eopl:error 'parse-expression "Expected ~a, but got ~s" expected datum)))

(eopl:printf "~s" (parse-prefix-exp '(- - - 1 1 1 - 1 1)))



