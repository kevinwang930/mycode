#lang racket

;HUFFMAN code tree sturcture
;leaf structure ('leaf symbol weight)
;note structure (left right symbols total-weight)


(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))


;decode function find alpabet one by one
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))))



(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;encode symbol my frist trial do not consider the symbol list in the code tree sturcture
; define one auxilary function to reserve result of every steps.
#;(define (encode-symbol element tree)
  (define (encode-symbol-1 element current-tree result)
    (cond
      ((leaf? current-tree)
       (if (eq? (symbol-leaf current-tree) element)
           (reverse result)
           #f))
      (else (let ((left-result (encode-symbol-1 element (left-branch current-tree) (cons 0 result))))
              (if left-result
                  left-result
                  (encode-symbol-1 element (right-branch current-tree) (cons 1 result)))))))
  (encode-symbol-1 element tree null))

; ENCODE 
(define (encode-symbol sym tree)
  (define (has-symbol? sym branch)
    (member sym (symbols branch)))
  (if (leaf? tree)
      null
      (let ((left (left-branch tree))
            (right (right-branch tree)))
        (cond ((has-symbol? sym left) (cons 0 (encode-symbol sym left)))
              ((has-symbol? sym right) (cons 1 (encode-symbol sym right)))
              (else #f)))))

; generate huffman code tree used in the decode and encode process

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) ; symbol
                               (cadr pair)) ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (if (< (length pairs) 2)
      (error "not enough leaves to generate huffman tree at least 2" 'generate-huffman-tree)
      (successive-merge (make-leaf-set pairs))))

(define (successive-merge leaves)
  (if (null? (cdr leaves))
      (car leaves)
      (let ((left (car leaves))
            (right (cadr leaves))
            (remains (cddr leaves)))
        (let ((new-branch (make-code-tree left right)))
          (successive-merge (adjoin-set new-branch remains))))))

#;(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

(define sample-tree
  (generate-huffman-tree '((C 1) (D 1) (B 2) (A 4))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define rock-song-tree
  (generate-huffman-tree '((A 2) (GET 2) (SHA 3) (WAH 1)
                                 (BOOM 1) (JOB 2) (NA 16) (YIP 9))))
(define rock-song
  '(GET A JOB
        SHA NA NA NA
        GET A JOB
        SHA NA NA NA
        WAH YIP YIP YIP
        SHA BOOM))

;test
(encode '(YIP) rock-song-tree)
(decode (encode rock-song rock-song-tree) rock-song-tree)
;(decode sample-message sample-tree)
;(decode (encode '(A D A B B C A) sample-tree) sample-tree)









