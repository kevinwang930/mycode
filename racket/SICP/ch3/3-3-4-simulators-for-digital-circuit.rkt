#lang racket

(require "3-3-2-queue-FIFO.rkt")

(define (execute proc)
  (proc))
;wire module 
(define (make-wire)
  (let ((signal-value 0)
        (action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
          (begin (set! signal-value new-value)
                 (call-each action-procedures))
          'done))
    (define (accept-action-procedure! proc)
      (set! action-procedures
            (cons proc action-procedures))
      ;(proc)
      )
    (define (dispatch m)
      (cond
        ((eq? m 'get-signal) signal-value)
        ((eq? m 'set-signal!) set-my-signal!)
        ((eq? m 'add-action!) accept-action-procedure!)
        ((eq? m 'check-action) action-procedures)
        (else (error "unknown operation: wire" m))))
    dispatch))

(define (call-each procedures)
  (if (null? procedures)
      'done
      (begin ((car procedures))
             (call-each (cdr procedures)))))

(define (get-signal wire)
  (wire 'get-signal))
(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))
(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))


;primitive function logical unit
(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error "invalid signal" s))))
(define (logical-and a1 a2)
  (if (and (= a1 1) (= a2 1))
      1
      0))
(define (logical-or a1 a2)
  (if (or (= a1 1) (= a2 1))
      1
      0))
(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! input invert-input) 'ok)
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

(define (after-delay delay action)
  (add-to-agenda! (+ delay (current-time the-agenda))
                  action
                  the-agenda))

(define (half-adder a b s c)
  (let ((d (make-wire))
        (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out))
  'ok)

(define (ripple-carry-adder a-list b-list c-in s-list c-out)
  (define (adder a-list b-list c-in  s-list)
    (let ((c (make-wire)))
      (full-adder (car a-list) (car b-list) c-in (car s-list) c)
      (if (null? (cdr a-list))
          (set-signal! c-out (get-signal c))
          (adder (cdr a-list) (cdr b-list) c-in (cdr s-list)))))
  (if (not (= (length a-list) (length b-list) (length s-list)))
      (error "inputs and output are not in same bits" )
      (adder a-list b-list c-in s-list)))




;implementing the agenda
;agenda structure (current-time segments)
;segment structure (time action-queue)

(define (make-time-segment time queue)
  (mcons time queue))
(define (segment-time s)
  (mcar s))
(define (segment-queue s)
  (mcdr s))

(define (make-agenda) (mcons 0 '()))
(define (current-time agenda) (mcar agenda))
(define (set-current-time! agenda time)
  (set-mcar! agenda time))
(define (segments agenda)
  (mcdr agenda))
(define (set-segments! agenda segments)
  (set-mcdr! agenda segments))
(define (first-segment agenda) (mcar (segments agenda)))
(define (rest-segments agenda) (mcdr (segments agenda)))
(define (empty-agenda? agenda)
  (null? (segments agenda)))

(define (add-to-agenda! time action agenda)
  (define (belongs-before? segments)
    (or (null? segments)
        (< time (segment-time (mcar segments)))))
  (define (make-new-time-segment time action)
    (let ((q (make-queue)))
      (insert-queue! q action)
      (make-time-segment time q)))
  (define (add-to-segments! segments)
    (cond
      ((= (segment-time (mcar segments)) time)
           (insert-queue! (segment-queue (mcar segments))
                       action))
      (else (let ((rest (mcdr segments)))
              (if (belongs-before? rest)
                  (set-mcdr! segments
                             (mcons (make-new-time-segment time action)
                                    rest))
                  (add-to-segments! rest))))))
  (let ((segments (segments agenda)))
    (if (belongs-before? segments)
        (set-segments! agenda (mcons (make-new-time-segment time action)
                                     segments))
        (add-to-segments! segments))))

(define (propagate)
  (if (empty-agenda? the-agenda)
      'done
      (let ((first-item (first-agenda-item the-agenda)))
        (execute first-item)
        (remove-first-agenda-item! the-agenda)
        (propagate))))


(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty: first-agenda-item")
      (let ((first-seg (first-segment agenda)))
        (set-current-time! agenda
                           (segment-time first-seg))
        (front-queue (segment-queue first-seg)))))

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (when (empty-queue? q)
      (set-segments! agenda (rest-segments agenda)))))

;simulation

(define (probe name wire)
  (add-action! wire
               (lambda ()
                 (newline)
                 (display name)
                 (display " ")
                 (display (current-time the-agenda))
                 (display "  New Value = ")
                 (display (get-signal wire)))))
(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 3)

;test
(define a (make-wire))
(define b (make-wire))
(define c (make-wire))
(define c-in (make-wire))
(define c-out (make-wire))
(define d (make-wire))
(define e (make-wire))
(define f (make-wire))
(define s1 (make-wire))
(define s2 (make-wire))
(define s3 (make-wire))
(define i1 (make-wire))
(define i2 (make-wire))
(define o1 (make-wire))
;(probe 's1-output s1)
(probe 'output e)

;(or-gate a b d)
;(and-gate a b c)
(inverter c e)
;(and-gate d e s)
;(full-adder a b c-in s c)
;(ripple-carry-adder (list a b c) (list d e f) c-in (list s1 s2 s3) c-out)
(propagate)


(set-signal! a 1)
(set-signal! b 1)
;(set-signal! c-in 1)
(propagate)
;(set-signal! b 1)
;(propagate)

