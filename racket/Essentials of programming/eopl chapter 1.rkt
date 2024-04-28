#lang racket

(define alphalist '(a b c a d c f g i j k))
(define numlist '(1 2 3 4 5 6 7))
(define in-s?
  (lambda (n)
          (if (zero? n) #t
              (if (>= (- n 3) 0)
                  (in-s? (- n 3))
                  #f))))


(define in-s1?
  (lambda (n k)
    (cond
      ((and (zero? n) (zero? (- k 1))) #t)
       ((and (>= (- n 1) 0) (>= (- k 7) 1)) (in-s1? (- n 1) (- k 7))))))



;(in-s1? 1 8)

#|ist-length : List → Int          contract   
usage: (list-length l) = the length of l
(define list-length
(lambda (lst)
...))|#

(define list-length
  (lambda (l)
    (if (null? l)
        0
        (+ 1 (list-length (cdr l))))))

;(list-length '(ab b c))
;(list-ref '(ab b c) 2)

#|Exercise 1.7  The error message from nth-element is uninformative. Rewrite
nth-element so that it produces a more informative error message, such as “(a b
c) does not have 8 elements.”   |#
(define nth-element
  (lambda (l n)
    (nth-element-helper l n l n)))
(define nth-element-helper
  (lambda (list n current-list i)
    (cond
      ((null? current-list) (list-too-short list n))
      ((zero? i) (car current-list))
      (else (nth-element-helper list n (cdr current-list) (- i 1))))))

(define list-too-short
  (lambda (list n)
    (error 'nth-element 
           "~s List does not have ~s  elements.~%" list (+ n 1))))
;(list-length alphalist)
;(nth-element alphalist 9)


;list-of-symbol::= ()|(symbol . list-of-symbol)
;remove-first:Sym * listof(Sym) -> Listof(Sym)
(define remove-first
  (lambda (e l)
    (cond
      ((null? l) (quote ()))
      ((eq? e (car l)) (cdr l))
      (else (cons (car l)
                  (remove-first e (cdr l)))))))

;(remove-first 'j alphalist)

(define remove
  (lambda (e l)
    (cond
      ((null? l) (quote ()))
      ((eq? e (car l)) (remove e (cdr l)))
      (else (cons (car l)
                  (remove e (cdr l)))))))

;(remove 'c alphalist)

;LcExp::= Identifier
;         (lambda (Identifier) LcExp)
;         (LcExp LcExp)
; occurs-free?:Sym*LcExp -> Boolean
(define occurs-free?
  (lambda (var exp)
    (cond
      ((null? exp) #f)
      ((symbol? exp) (eqv? var exp))
      ((and (eqv? (quote lambda) (car exp))
            (not (eqv? var (car (car (cdr exp))))))
          (occurs-free? var (cdr (cdr exp))))
      (else (or (occurs-free? var (car exp))
                 (occurs-free? var (cdr exp)))))))

#;(occurs-free? 'list1 '(lambda (e l)
      (((null? list1) (quote ()))
       ((e (car l)) (e (cdr l))))))



;S-list::= ({S-exp}*)
;S-exp::=Symbol | S-list
#|(define subst
  (lambda (new old slist)
    (cond
      ((null? slist) (quote ()))
      (else
       (map (subst-in-s-exp new old) slist)))))

(define subst-in-s-exp
  (lambda (new old)
    (lambda (sexp)
    (cond
      ((symbol? sexp)
       (cond
         ((eqv? sexp old) new)
         (else sexp)))
      (else subst new old sexp)))))   |#

(define subst
  (lambda (new old slist)
    (cond
      ((null? slist) (quote ()))
      (else
       (map (lambda (sexp) (subst-in-s-exp new old sexp)) slist)))))

(define subst-in-s-exp
  (lambda (new old sexp)
    (cond
      ((symbol? sexp)
       (cond
         ((eqv? sexp old) new)
         (else sexp)))
      (else subst new old sexp))))


#|
S-list::=(S-exp . S-list)
S-exp ::=Symbol | S-list

;subst:Sym*Sym*Slist -> Slist
(define subst
  (lambda (new old slist)
    (cond
      ((null? slist) (quote ()))
      (else
       (cons (subst-in-s-exp new old (car slist))
             (subst (cdr slist)))))))

(define subst-in-s-exp
  (lambda (new old sexp)
    (cond
      ((symbol? sexp)
       (cond
         ((eqv? sexp old) new)
         (else sexp)))
      (else subst new old sexp))))



(define subst
  (lambda (new old slist)
    (cond
      ((null? slist) (quote ()))
      ((symbol? (car slist))
       (if (eqv? old (car slist)) (cons new (subst new old (cdr slist)))
                                  (cons (car slist) (subst new old (cdr slist)))))
      (else (cons (subst new old (car slist))
                  (subst new old (cdr slist))))))) |#

;(subst 'test 'a alphalist)

;number-element-from:Listof(SchemeVal)*Int -> Listof(List(Int SchemeVal))
#|(define number-element-from
  (lambda (list n)
    (cond
      ((null? list) (quote ()))
      (else (cons (cons n (cons (car list)
                                (quote ()))) 
                  (number-element-from (cdr list) (+ n 1)))))))
;number-element:Listof(SehemeVal)*Int -> Listof(List(Int SchemeVal))
(define number-element
  (lambda (list)
    (number-element-from list 0)))  |#
;(number-element alphalist)

;List-sum:Listof(Int)-> Int
(define List-sum
  (lambda (numlist)
    (cond
      ((null? numlist) 0)
      (else (+ (car numlist)
               (List-sum (cdr numlist)))))))

;(List-sum numlist)
;partial-vector-sum:Vectorof(Int)*Int -> Int
(define partial-vector-sum
  (lambda (v n)
    (if (zero? n)
        (vector-ref v 0)
        (+ (vector-ref v n)
           (partial-vector-sum v (- n 1))))))
;vector-sum:Vectorof(Int) -> Int
(define vector-sum
  (lambda (v)
    (let ((n (vector-length v)))
      (if (zero? n)
          0
          (partial-vector-sum v (- n 1))))))

;(vector-sum (vector 1 2 3))
;duple:Int*X ->({x}n)
(define duple
  (lambda (n x)
    (cond
      ((zero? n) (quote ()))
      (else (cons x
                  (duple (- n 1) x))))))
;(duple 3 2)
;(duple 3 '(ha ha))
;invert:Listof({(S-exp1 S-exp2)}*) -> Listof({(S-exp2 S-exp1)}*)
(define invert
  (lambda (list)
    (cond
      ((null? list) (quote ()))
      (else (cons (invert-single (car list))
                  (invert (cdr list)))))))
;invert-single:Listof(S-exp1 S-exp2) -> Listof(S-exp2 S-exp1)
(define invert-single
  (lambda (list1)
    (list (car (cdr list1))
          (car list1))))
;(invert '((1 2) (3 4) (7 8)))
;down:Listof({S-exp}*) -> Listof({(S-exp)}*)
(define down
  (lambda (lst)
    (cond
      ((null? lst) (quote ()))
      (else (cons (cons (car lst)
                        (quote ()))
                  (down (cdr lst)))))))
;(down alphalist)
;(down '((a) (fine) (idea)))

;swapper:Sym1*Sym2*List -> List
(define swapper
  (lambda (s1 s2 lst)
    (cond
      ((null? lst) (quote ()))
      ((symbol? (car lst)) (cons (swapper-symbol s1 s2 (car lst))
                                 (swapper s1 s2 (cdr lst))))
      (else (cons (swapper s1 s2 (car lst))
                  (swapper s1 s2 (cdr lst)))))))
(define swapper-symbol
  (lambda (s1 s2 cl)
    (cond
      ((eq? s1 cl) s2)
      ((eq? s2 cl) s1)
      (else cl))))
;(swapper 'a 'b alphalist)
;(swapper 'x 'y '((x) y (z (x))))

;list-set:List*Int*S-exp -> List
#|(define list-set
  (lambda (lst n x)
    (cond
      ((null? lst)  (error 'list-set "List does not have enough elements"))
      ((eq? n 0) (cons x (cdr lst)))
      (else (list-set-helper (lambda (x) (cons (car lst) x)) (cdr lst) (- n 1) x)))))
(define list-set-helper
  (lambda (return-lst lst n x)
    (cond
      ((null? lst) (error 'list-set "List does not have enough elements"))
      ((eq? n 0) (return-lst
                       (cons x
                             (cdr lst))))
      (else (list-set-helper (lambda (x) (return-lst (cons (car lst) x))) (cdr lst) (- n 1) x)))))
(list-set alphalist 3 'test)   |#

(define list-set
  (lambda (lst n x)
    (cond
      ((null? lst) (error 'list-set "List does not have enough elements"))
      ((zero? n) (cons x (cdr lst)))
      (else (cons (car lst)
                  (list-set (cdr lst) (- n 1) x))))))
;(list-set alphalist 3 'test)
;(list-set '(a b c d) 2 '(1 2))
;count-occurances:Symbol*List -> Int
(define count-occurances
  (lambda (x lst)
    (cond
      ((null? lst) 0)
      ((symbol? (car lst))
       (if (eq? x (car lst)) (+ 1 (count-occurances x (cdr lst)))
                             (count-occurances x (cdr lst))))
      (else (+ (count-occurances x (car lst))
               (count-occurances x (cdr lst)))))))
;(count-occurances 'x '((f x) y (((x z) () x))))

;product:List*List->List
(define product
  (lambda (l1 l2)
    (cond
      ((or (null? l1) (null? l2)) (quote ()))
      (else (partial-product l1 (car l2) (product l1 (cdr l2)))))))
(define partial-product
  (lambda (l1 S result)
    (cond
    ((null? l1) result)
    (else (cons (list (car l1) S)
                (partial-product (cdr l1) S result))))))
;(product alphalist numlist)
;(product '(a b c) '(x y))
;filter-in:Procedure*List -> list
(define filter-in
  (lambda (pred lst)
    (cond
      ((null? lst) (quote ()))
      ((pred (car lst)) (cons (car lst)
                              (filter-in pred (cdr lst))))
      (else (filter-in pred (cdr lst))))))
;(filter-in number? '(a b 2 3 5 c d))
;(filter-in symbol? '(a (b c) 17 foo))
;list-index:Pred*List-> Int
(define list-index
  (lambda (Pred lst)
    (list-index-helper Pred lst 0) ))
(define list-index-helper
  (lambda (pred lst n)
    (cond
      ((null? lst) #f)
      (else
       (let ((element (car lst)))
         (cond
           ((pred element) n)
           (else (list-index-helper pred (cdr lst) (+ n 1)))))))))
;(list-index number? '(a 2 (1 3) b 7))
;every?:pred*List -> Boolean
(define every?
  (lambda (pred lst)
    (if (null? lst) #t
     (if (pred (car lst))
        (every? pred (cdr lst))
        #f))))
;(every? number? '(1 2 3 5 4))

;exists?:pred*List -> Boolean
(define exists?
  (lambda (pred lst)
    (if (null? lst) #f
        (or (pred (car lst))
         (exists? pred (cdr lst))))))
;(exists? number? '(a b c 3 e))

;up:Listof({S-exp}*) -> List
#|(define up
  (lambda (lst)
    (cond
      ((null? lst) (quote ()))
      (else
       (let ((element (car lst))
             (tail (up (cdr lst))))
         (if (symbol? element)
             (cons element tail)
             (up-single-list element tail)))))))
(define up-single-list
  (lambda (lst tail)
    (cond
      ((null? lst) tail)
      (else (cons (car lst)
                  (up-single-list (cdr lst) tail))))))|#

(define up
  (lambda (lst)
    (cond
      ((null? lst) (quote ()))
      (else (up-element (car lst) (up (cdr lst)))))))
(define up-element
  (lambda (element tail)
    (if (symbol? element)
        (cons element tail)
        (extend-head element tail))))
(define extend-head
  (lambda (lst tail)
    (if (null? lst)
        tail
        (cons (car lst)
              (extend-head (cdr lst) tail)))))
;(up '((1 2) (3 4)))
;(up '((x (y)) z))

;flatten:List -> List

(define flatten
  (lambda (lst)
    (if (null? lst)
        (quote ())
        (flatten-list lst '()))))

(define flatten-element
  (lambda (element tail)
    (if (symbol? element)
        (cons element tail)
        (flatten-list element tail))))
(define flatten-list
  (lambda (lst tail)
    (if (null? lst)
        tail
        (flatten-element (car lst) (flatten-list (cdr lst) tail)))))

;(flatten '((x (y)) z))
;(flatten '((a b) c (((d)) e)))
;merge:List*List -> List
#;(define merge
  (lambda (loi1 loi2)
    (cond
      ((null? loi1) loi2)
      ((null? loi2) loi1)
      (else
       (let ((e1 (car loi1))
             (e2 (car loi2)))
         (if (<= e1 e2)
             (cons e1 (merge (cdr loi1) loi2))
             (cons e2 (merge loi1 (cdr loi2)))))))))


;(merge '(3 7 9) '(1 10))
;(merge '(35 62 81 90 91) '(3 83 85 90))

;sort:List -> List
#|(define sort
  (lambda (lst)
    (cond
      ((null? lst) '())
      ((null? (cdr lst)) lst)
      (else
       (sort-insert (car lst) (sort (cdr lst)))))))
(define sort-insert
  (lambda (int lst)
    (cond
      ((null? lst) (cons int '()))
      (else (if (>= int (car lst))
                (cons (car lst) (sort-insert int (cdr lst)))
                (cons int lst))))))  |#

#|(define get-run
  (lambda (loi)
    (let ([head1 (car loi)]
          [tail1 (cdr loi)])
      (if (null? tail1)
          (cons loi '())
          (let ([head2 (car tail1)])
            (if (<= head1 head2)
                (let ([tail-run (get-run tail1)])
                  (cons (cons head1
                              (car tail-run))
                        (cdr tail-run)))
                (cons (list head1) tail1)))))))

(define merge
  (lambda (run1 run2)
    (let ([head1 (car run1)]
          [head2 (car run2)])
      (if (<= head1 head2)
          (let ([tail1 (cdr run1)])
            (if (null? tail1)
                (cons head1 run2)
                (cons head1 (merge tail1 run2))))
          (let ([tail2 (cdr run2)])
            (if (null? tail2)
                (cons head2 run1)
                (cons head2 (merge run1 tail2))))))))

(define collapse-all
  (lambda (stack run)
    (if (null? stack)
        run
        (collapse-all (cdr stack) (merge (cdar stack) run)))))

(define collapse
  (lambda (stack level run)
    (if (null? stack)
        (list (cons level run))
        (let ([top (car stack)])
          (if (= (car top) level)
              (collapse (cdr stack) (+ level 1) (merge (cdr top) run))
              (cons (cons level run) stack))))))

(define sort-helper
  (lambda (stack loi)
    (let* ([run-and-tail (get-run loi)]
           [run (car run-and-tail)]
           [tail (cdr run-and-tail)])
      (if (null? tail)
          (collapse-all stack run)
          (sort-helper (collapse stack 0 run) tail)))))

(define sort
  (lambda (loi)
    (if (null? loi)
        '()
        (sort-helper '() loi))))|#

;(sort '(1 3 0 5 2 7 21 4 9 6 8))

(define get-run
  (lambda (pred loi)
    (let ([head1 (car loi)]
          [tail1 (cdr loi)])
      (if (null? tail1)
          (cons loi '())
          (let ([head2 (car tail1)])
            (if (pred head1 head2)
                (let ([tail-run (get-run pred tail1)])
                  (cons (cons head1
                              (car tail-run))
                        (cdr tail-run)))
                (cons (list head1) tail1)))))))

(define merge
  (lambda (pred run1 run2)
    (let ([head1 (car run1)]
          [head2 (car run2)])
      (if (pred head1 head2)
          (let ([tail1 (cdr run1)])
            (if (null? tail1)
                (cons head1 run2)
                (cons head1 (merge pred tail1 run2))))
          (let ([tail2 (cdr run2)])
            (if (null? tail2)
                (cons head2 run1)
                (cons head2 (merge pred run1 tail2))))))))

(define collapse-all
  (lambda (pred stack run)
    (if (null? stack)
        run
        (collapse-all pred (cdr stack) (merge pred (cdar stack) run)))))

(define collapse
  (lambda (pred stack level run)
    (if (null? stack)
        (list (cons level run))
        (let ([top (car stack)])
          (if (= (car top) level)
              (collapse pred (cdr stack) (+ level 1) (merge pred (cdr top) run))
              (cons (cons level run) stack))))))

(define sort-helper
  (lambda (pred stack loi)
    (let* ([run-and-tail (get-run pred loi)]
           [run (car run-and-tail)]
           [tail (cdr run-and-tail)])
      (if (null? tail)
          (collapse-all pred stack run)
          (sort-helper pred (collapse pred stack 0 run) tail)))))

(define sort/predicate
  (lambda (pred loi)
    (if (null? loi)
        '()
        (sort-helper pred '() loi))))

;(sort/predicate < '(1 3 0 5 2 7 21 4 9 6 8))
;(sort/predicate > '(1 3 0 5 2 7 21 4 9 6 8))
;Bintree::= int | (symbol bintree bintree)
(define interior-node
  (lambda (symbol left-child right-child)
    (list symbol
          left-child
          right-child)))
(define leaf
  (lambda (num)
    num))
(define leaf? integer?)
(define lson cadr)
(define rson caddr)
(define contents-of
  (lambda (bin-tree)
    (if (leaf? bin-tree)
        bin-tree
        (car bin-tree))))
(define double-tree
  (lambda (bin-tree)
    (if (integer? bin-tree)
        (leaf (* bin-tree 2))
        (interior-node (contents-of bin-tree)
                       (double-tree (lson bin-tree))
                       (double-tree (rson bin-tree))))))
;(double-tree '(a (b 4 5) (c 5 7)))
;mark-leaves-with-red-depth:Bin-tree -> Bin-tree
(define red-root-bintree
  (interior-node 'red
                (interior-node 'bar
                               (leaf 26)
                               (leaf 12))
                (interior-node 'red
                               (leaf 11)
                               (interior-node 'quux
                                              (leaf 117)
                                              (leaf 14)))))
(define mark-leaves-with-red-depth
  (lambda (bintree)
    (if (leaf? bintree)
        bintree
        (if (eq? 'red (contents-of bintree))
            (mark-leaves-with-red-depth-helper -1 bintree)
            bintree))))

(define mark-leaves-with-red-depth-helper
  (lambda (level bintree)
    (if (leaf? bintree)
        level
        (interior-node (contents-of bintree)
                       (mark-leaves-with-red-depth-helper (+ level 1) (lson bintree))
                       (mark-leaves-with-red-depth-helper (+ level 1) (rson bintree))))))

;(mark-leaves-with-red-depth red-root-bintree)

;Binary-search-tree::= ()|(Int Binary-search-tree Binary-search-tree)
;path:Integer*Binary-search-tree -> Listof({right|Left}*)

(define path
  (lambda (n bst)
    (let ((head (car bst)))
      (if (< n head)
          (cons 'left
                (path n (cadr bst)))
          (if (= n head)
              '()
              (cons 'right
                    (path n (caddr bst))))))))

#;(path 17 '(14 (7 () (12 () ()))
              (26 (20 (17 () ())
                        ())
                  (31 () ()))))

;number-leaves:Bintree -> Bintree
(define number-leaves
  (lambda (bintree)
    (if (leaf? bintree)
        0
        (car (number-leaves-helper bintree 0)))))

(define number-leaves-helper
  (lambda (bintree n)
    (if (leaf? bintree)
        (cons (leaf n) (+ n 1))
        (let* ((left-result (number-leaves-helper (lson bintree) n))
               (right-result (number-leaves-helper (rson bintree) (cdr left-result))))
          (cons (interior-node (contents-of bintree)
                         (car left-result)
                         (car right-result))
                (cdr right-result))))))

#;(number-leaves
 (interior-node 'foo
                (interior-node 'bar
                               (leaf 26)
                               (leaf 12))
                (interior-node 'baz
                               (leaf 11)
                               (interior-node 'quux
                                              (leaf 117)
                                              (leaf 14)))))

(define number-elements
  (lambda (lst)
    (if (null? lst)
        '()
        (g (list 0 (car lst)) (number-elements (cdr lst))))))

(define g
  (lambda (head tail)
    (cons head
          (map (lambda (item)
                 (list (+ (car item) 1) (cadr item)))
               tail))))

;(number-elements alphalist)






























