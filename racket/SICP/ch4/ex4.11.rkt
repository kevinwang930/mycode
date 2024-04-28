#lang racket
(require "../ch3/3-3-3-tables.rkt")

;data-directed programming table
(define proc-table (make-table))
(define (get proc-tag)
  (lookup proc-tag proc-table))
(define (put proc-tag proc)
  (insert! proc-tag proc proc-table))


(define (eval exp env)
  (cond
    ((self-evaluating? exp) exp)
    ((variable? exp) (lookup-variable-value exp env))
    ((quoted? exp) (text-of-quotation exp))
    ((assignment? exp) (eval-assignment exp env))
    ((definition? exp) (eval-definition exp env))
    ((if? exp) (eval-if exp env))
    ((lambda? exp) (make-procedure (lambda-parameters exp)
                                   (lambda-body exp) env))
    ((begin? exp) (eval-sequence (begin-actions exp) env))
    ((cond? exp) (eval (cond->if exp) env))
    ((and? exp) (eval-and exp env))
    ((or? exp) (eval-or exp env))
    ((let? exp) (eval (let->combination exp) env))
    ((let*? exp) (eval (let*->combination exp) env))
    ((for? exp) (eval (for->combination exp) env))
    ((application? exp) (apply# (eval (operator exp) env)
                               (list-of-values (operands exp) env)))
    (else (error "Unknown expression type: EVAL" exp))))

;data-directed programming
(define (install-syntax)
  (put 'quote eval-quoted)
  (put 'set! eval-assignment)
  (put 'define eval-definition)
  (put 'if eval-if)
  (put 'lambda eval-lambda)
  (put 'begin eval-begin)
  (put 'cond eval-cond)
  (put 'and eval-and)
  (put 'or eval-or)
  (put 'let eval-let)
  (put 'let* eval-let*)
  (put 'for eval-for)
  'syntax-installed)

(define (apply# procedure arguments)
  (cond
    ((primitive-procedure? procedure)
     (apply-primitive-procedure procedure arguments))
    ((compound-procedure? procedure)
     (eval-sequence (procedure-body procedure)
                     (extend-environment
                     (procedure-parameters procedure)
                     arguments
                     (procedure-environment procedure))))
    (else
     (error "Unknown procedure type: APPLY" procedure))))


(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

;implementation of environment
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define (add-frame frame env)
  (cons frame env))

(define the-empty-environment '())

;representation of frame with frame variable unit (mcons var val)
;((var val) ...)

(define the-empty-frame '())
(define (empty-frame? frame) (null? frame))
(define (make-frame variables values)
  (if (null? variables)
      the-empty-frame
      (let ((first-binding (mcons (car variables) (car values))))
        (mcons first-binding
               (make-frame (cdr variables) (cdr values))))))

(define (add-binding-to-frame! var val frame)
  (let ((new-binding (mcons var val)))
    (set-mcdr! frame (mcons (mcar frame) (mcdr frame)))
    (set-mcar! frame new-binding)))
(define (first-binding frame)
  (mcar frame))
(define (rest-bindings frame)
  (mcdr frame))
(define (lookup-variable-value-in-frame var frame)
  (define (scan var mframe)
    (if (empty-frame? mframe)
        (raise 1)
        (let ((first-binding (mcar mframe)))
          (if (eq? (mcar first-binding) var)
              (mcdr first-binding)
              (scan var (rest-bindings mframe))))))
  (scan var frame))

(define (set-variable-value-in-frame! var val frame)
  (define (scan var val mframe)
    (if (empty-frame? mframe)
        false
        (let ((first-binding (mcar mframe)))
          (if (eq? (mcar first-binding) var)
              (set-mcdr! first-binding val)
              (scan var val (rest-bindings mframe))))))
  (scan var val frame))

(define (set-or-add-variable-value-in-frame! var val frame)
  (define (scan var val mframe)
    (if (empty-frame? mframe)
        (add-binding-to-frame! var val frame)
        (let ((first-binding (mcar mframe)))
          (if (eq? (mcar first-binding) var)
              (set-mcdr! first-binding val)
              (scan var val (rest-bindings mframe))))))
  (scan var val frame))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (with-handlers ((number?  (lambda (x) (env-loop (enclosing-environment env)))))
              (lookup-variable-value-in-frame var frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let* ((frame (first-frame env))
               (set-result (set-variable-value-in-frame! var val frame)))
          (if set-result
              set-result
              (env-loop (enclosing-environment env))))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (set-or-add-variable-value-in-frame! var val frame)))


(define (extend-environment vars vals base-env)
  (if (= (length vars)
         (length vals))
      (add-frame (make-frame vars
                             vals)
                        base-env)
      (error "required ~a arguments supplied ~b" vars vals)))

;frame representation with separate variables and values
#|
(define (frame-variables frame) (mcar frame))
(define (frame-values frame) (mcdr frame))
(define (make-frame variables values)
  (mcons (list->mlist variables)
         (list->mlist values)))
(define (add-binding-to-frame! var val frame)
  (set-mcar! frame (mcons var (mcar frame)))
  (set-mcdr! frame (mcons val (mcdr frame))))
(define (extend-environment vars vals base-env)
  (if (= (length vars)
         (length vals))
      (cons (make-frame vars
                        vals)
                        base-env)
      (error "required ~a arguments supplied ~b" vars vals)))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (mcar vars)) (mcar vals))
            (else (scan (mcdr vars) (mcdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

|#






;variable
(define (variable? exp) (symbol? exp))

;predicate
(define (true? x) (not (eq? x false)))
(define (false? x) (eq? x false))


;quotations
(define (quoted? exp) (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))
(define (eval-quoted exp env) (text-of-quotation exp))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))
(define (type-tag exp)
  (if (pair? exp)
      (car exp)
      #f))
;auxiliary function
(define (list->mlist l)
  (if (null? l)
      '()
      (mcons (car l)
             (list->mlist (cdr l)))))
(define (mlength mlist)
  (if (null? mlist)
      0
      (+ 1 (mlength (mcdr mlist)))))


;assignments
(define (assignment? exp) (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
  'ok)

;definitions
(define (definition? exp) (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
                   (cddr exp))))

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (eval (definition-value exp) env)
                    env)
  'ok)

;lambda expressions
(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
(define (make-lambda parameters body-sequences)
  (cons 'lambda (cons parameters body-sequences)))
(define (eval-lambda exp env)
  (make-procedure (lambda-parameters exp)
                  (lambda-body exp)
                  env))

;conditionals
;if
(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))
(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

;and
(define (and? exp) (tagged-list? exp 'and))
(define (eval-and exp env)
  (define and-clauses (cdr exp))
  (define (expand-clauses clauses)
    (let ((first-result (eval (first-exp clauses) env)))
      (cond ((last-exp? clauses) first-result)
            (first-result (expand-clauses (rest-exps clauses)))
            (else false))))
  (expand-clauses and-clauses))

;or
(define (or? exp) (tagged-list? exp 'or))
(define (eval-or exp env)
  (define or-clauses (cdr exp))
  (define (expand-clauses clauses)
    (let ((first-result (eval (first-exp clauses) env)))
      (cond ((last-exp? clauses) first-result)
            (first-result true)
            (else (expand-clauses (rest-exps clauses))))))
  (expand-clauses or-clauses))

;begin expressions
(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
  (cond
    ((null? seq) seq)
    ((last-exp? seq) (first-exp seq))
    (else (make-begin seq))))
(define (make-begin seq)
  (cons 'begin seq))

(define (eval-sequence exps env)
  (cond
    ((last-exp? exps)
     (eval (first-exp exps) env))
    (else (eval (first-exp exps) env)
          (eval-sequence (rest-exps exps) env))))

(define (eval-begin exp env)
  (eval-sequence (begin-actions exp) env))


;procedure application
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

(define (list-of-values-l-r exps env)
  (if (no-operands? exps)
      '()
      (let ((left (eval (first-operand exps) env)))
        (let ((right (list-of-values (rest-operands exps) env)))
          (cons left right)))))

(define (list-of-values-r-l exps env)
  (if (no-operands? exps)
      '()
      (let ((right (list-of-values (rest-operands exps) env)))
        (let ((left (eval (first-operand exps) env)))
          (cons left right)))))
(define (procedure-parameters p)
  (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))
(define (primitive-implementation proc)
  (cadr proc))

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '+ +)
        (list '- -)
        (list '= =)
        (list 'void void)
        ))
(define (primitive-procedure-names)
  (map car primitive-procedures))
(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
                   primitive-procedures))
(define (apply-primitive-procedure proc args)
  (apply-in-underlying-racket (primitive-implementation proc)
                              args))
(define apply-in-underlying-racket apply)


;derived expression
;cond->if

(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))

(define (cond-recipient-clause? clause)
  (eq? (car (cond-actions clause)) '=>))
(define (cond-recipient-action clause)
  (cadr (cond-actions clause)))

(define (cond-consequent clause predicate)
  (if (cond-recipient-clause? clause)
      (list (cond-recipient-action clause) predicate)
      (sequence->exp (cond-actions clause))))
(define (cond->if exp) (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "else clause isn't last: cond->if" clauses))
            (let ((predicate (cond-predicate first)))
                (make-if predicate
                         (cond-consequent first predicate)
                         (expand-clauses rest)))))))
(define (eval-cond exp env)
  (eval (cond->if exp) env))

;let->combination
;(let ((Var val)..) body) -> ((lambda (vars) body) vals)
;eval process: let->lambda->procedure
(define (let? exp) (tagged-list? exp 'let))
(define (let-clauses exp) (cadr exp))
(define (last-clause? clauses) (null? (cdr clauses)))
(define (clause-variable clause) (car clause))
(define (clause-value clause) (cadr clause))

(define (named-let? exp) (symbol? (cadr exp)))
(define (named-let-name exp) (cadr exp))
(define (named-let-clauses exp) (caddr exp))
(define (named-let-body exp) (cdddr exp))
(define (named-let-variables exp) (map car (named-let-clauses exp)))
(define (named-let-values exp) (map cadr (named-let-clauses exp)))
(define (let-body exp) (cddr exp))
(define (let-variables exp) (map car (let-clauses exp)))
(define (let-values exp) (map cadr (let-clauses exp)))
(define (make-let let-clauses let-body-sequences)
  (cons 'let
        (cons let-clauses
              let-body-sequences)))
(define (eval-let exp env)
  (eval (let->combination exp) env))
#;(define (let->combination exp)
  (if (named-let? exp)
      (let ((name (named-let-name exp))
            (variables (named-let-variables exp))
            (values (named-let-values exp))
            (body (named-let-body exp)))
        (let* ((let-procedure (make-lambda variables body))
              (translated-let-clause (list name let-procedure)))
          (make-let (list translated-let-clause)
                    (list (cons name values)))))
      (cons (make-lambda (let-variables exp)
                         (let-body exp))
            (let-values exp))))
(define (let->combination exp)
  (if (named-let? exp)
      (let ((name (named-let-name exp))
            (variables (named-let-variables exp))
            (values (named-let-values exp))
            (body (named-let-body exp)))
        (make-begin (list (cons 'define
                                (cons (cons name variables)
                                      body))
                          (cons name values))))
      (cons (make-lambda (let-variables exp)
                         (let-body exp))
            (let-values exp))))

;let*
(define (let*? exp) (tagged-list? exp 'let*))
(define (make-let* let-clauses let-body)
   (cons 'let*
              (cons let-clauses let-body)))
(define (let*->combination exp)
  (let ((clauses (let-clauses exp)))
    (if (last-clause? clauses)
        (let->combination exp)
        (let ((first-clause (car clauses))
              (rest-clauses (cdr clauses)))
          (let ((rest-let* (make-let* rest-clauses (let-body exp))))
            (list (make-lambda (list (clause-variable first-clause))
                               (list rest-let*))
                  (clause-value first-clause)))))))

;let*
; (let* ((var1 val1) (var2 val2)...) body)
; (lambda (var1) (let* ((var2 val2)) body) val1)
(define (eval-let* exp env)
  (eval (let*->combination exp) env))

;directly extend environment to deal with let*
(define (eval-let*-1 exp env)
  (let ((clauses (let-clauses exp)))
    (if (last-clause? clauses)
        (eval (let->combination exp) env)
        (let ((first-clause (car clauses))
              (rest-clauses (cdr clauses)))
          (let ((rest-let* (make-let* rest-clauses (let-body exp))))
            (eval rest-let*
                  (extend-environment (list (clause-variable first-clause))
                                      (list (eval (clause-value first-clause) env))
                                      env)))))))
;(for for-clauses body)
(define (for? exp) (tagged-list? exp 'for))
(define (for-clauses exp) (cadr exp))
(define (for-body exp) (cddr exp))
(define (for-variables exp) (map car (for-clauses exp)))
(define (for-value-seqs exp) (map cadr (for-clauses exp)))
(define (check-null? seqs) (if (null? seqs)
                               false
                               (or (null? (car seqs))
                                   (check-null? (cdr seqs)))))

(define (lambda-value-seqs for-seqs)
  (if (null? (car for-seqs))
      '()
      (cons (map car for-seqs)
            (lambda-value-seqs (map cdr for-seqs)))))
(define (for-expand for-procedure value-seqs)
  (if (null? (car value-seqs))
      (list '(void))
      (let ((first-values (map car value-seqs))
            (rest-values (map cdr value-seqs)))
        (cons (cons for-procedure first-values)
              (for-expand for-procedure rest-values)))))

(define (for->combination exp)
  (let ((for-lambda (make-lambda (for-variables exp)
                                 (for-body exp)))
        (for-name (gensym 'for))
        (value-seqs (for-value-seqs exp)))
    (make-begin (cons (list 'define for-name for-lambda)
                      (for-expand for-name value-seqs)))))
(define (eval-for exp env)
  (eval (for->combination exp) env))


;run evaluator as program
(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define the-global-environment (setup-environment))
(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))
(define (announce-output string)
  (newline) (display string) (newline))
(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))


(define (interpret exp)
  (eval exp the-global-environment))
#;(extend-environment (list->mlist (list 'a))
                    (list->mlist (list 2))
                    the-empty-environment)

;(install-syntax)

;(driver-loop)
(provide (all-defined-out))


#;(interpret '(define combine (let ((a 1))
                               (lambda (x)
                                 (set! a (+ a x))
                                 a))))
;(interpret '(combine 1))
#|
(make-frame (list 'a)
            (list 1))
(first-binding (make-frame (list 'a)
                           (list 1)))
(interpret '(define a 1))
|#
;the-global-environment
;(lookup-variable-value 'false the-global-environment)


















