#lang racket
(require)
;set is a collection of distinct object
;we define set by sepecifying the operations are to be used on sets
; union-set intersection-set element-of-set? adjoin-set? 


;;;set as unordered list with no-duplicate

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (remove-duplicate s)
  (cond  ((null? s) null)
         ((element-of-set? (car s) (cdr s))
          (remove-duplicate (cdr s)))
         (else (cons (car s)
                 (remove-duplicate (cdr s))))))

(define (union set1 set2)
  (remove-duplicate (append set1 set2)))



;set as ordered-list set elements are numers

(define (element-of-ordered-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-ordered-set? x (cdr set)))))

(define (intersection-ordered-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-ordered-set (cdr set1)
                                          (cdr set2))))
              ((< x1 x2)
               (intersection-ordered-set (cdr set1) set2))
              ((> x1 x2)
               (intersection-ordered-set set1 (cdr set2)))))))

(define (adjoin-ordered-set x s)
  (cond ((null? s) (cons x s))
        ((= x (car s)) s)
        ((< x (car s)) (cons x s))
        (else (cons (car s)
                    (adjoin-ordered-set x (cdr s))))))

(define (union-ordered-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (union-ordered-set (cdr set1) (cdr set2))))
              ((< x1 x2)
               (cons x1 (union-ordered-set (cdr set1) set2)))
              ((< x2 x1)
               (cons x2 (union-ordered-set set1 (cdr set2)))))))))

;sets as binary tree
;represents sets in terms of trees, and trees in terms of lists
; data absturction built upon a data abstraction
; procedures entry left-branch righ-branch and make trees as 
;barrier to isolate the data abstraction to a particular way a
;tree might be represented.

;tree constructor and selector
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

; set
(define (element-of-tree-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-tree-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-tree-set? x (right-branch set)))))

(define (adjoin-tree-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-tree-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set) (left-branch set)
                    (adjoin-tree-set x (right-branch set))))))

;tree->list
;1) define copy to list function
;2) copy right tree to list
;3) cons entry to list
;4) copy left tree to list
(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree null))


(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
               (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

(define (union-tree-set t1 t2)
  (let ((l1 (tree->list t1))
        (l2 (tree->list t2)))
     (list->tree (union-ordered-set l1 l2))))
;(entry1 lb1 rb1)
;(entry2 lb2 rb2)

;if entry1 < entry2  element of lb1 < elements of rb2

(define (intersection-tree-set t1 t2)
  (let ((l1 (tree->list t1))
            (l2 (tree->list t2)))
        (list->tree (intersection-ordered-set l1 l2))))
(define (lookup given-key tree-of-records)
  (if (null? tree-of-records)
      false
      (let ((current-record (entry tree-of-records)))
        (cond
          ((equal? given-key (key current-record))
           (content current-record))
          ((< given-key (key current-record))
           (lookup given-key (left-branch tree-of-records)))
          (else (lookup given-key (right-branch tree-of-records)))))))

(define (make-record key content)
  (if (number? key)
      (list key content)
      (error "key is not a number" 'make-record)))
(define (key record)
  (car record))
(define (content record)
  (cadr record))
(define test-records 
  (list->tree
   (list (make-record 1 "andy") 
         (make-record 2 "bob") 
         (make-record 3 "carol") 
         (make-record 4 "deepak") 
         (make-record 5 "ethel")
         (make-record 6 "freidel")
         (make-record 7 "guido")
         (make-record 8 "harold"))))
(lookup 1 test-records)

 ;how partial tree works (1 3 5 7 9 11)
#|
1) calculate left tree size (- n 1) / 2
2) build left tree from (1 3)
3）entry-element 5
4) build right-tree (7 9 11)
5) combine make-tree entry left right
6) recursion stops when it finds n equal to 0

|#
;test
(define tree1
  (make-tree 7 (make-tree 3 (make-tree 1 null null)
                          (make-tree 5 null null))
             (make-tree 9 null (make-tree 11 null null))))
 
(define tree2
  (make-tree 3
             (make-tree 1 null null)
             (make-tree 7
                        (make-tree 5 null null)
                        (make-tree 9 null (make-tree 11 null null)))))
 
(define tree3
  (make-tree 5
             (make-tree 3 (make-tree 1 null null) null)
             (make-tree 9
                        (make-tree 7 null null)
                        (make-tree 11 null null))))

(define tree4 (list->tree '(1 2 3 4 5 6 7 8 9)))
;(tree->list tree3)
;(union-ordered-set (list 1 2 3) (list 2 3 4))
;(union (list 1 2 3 'a) (list 2 3 4 '(+ 1 2)))
;(partial-tree '(1 3 5) 3)
(union-tree-set tree2 tree3)
(intersection-tree-set tree4 tree3)












