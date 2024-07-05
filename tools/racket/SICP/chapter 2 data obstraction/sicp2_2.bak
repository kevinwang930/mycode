#lang racket
;hierarchical data and closure
;closure property the ability to create data structure whose elements can be the same data structure.
(require "../basic_function.rkt")
;(require sicp-pict)
(require graphics/graphics)
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define squares (list 1 4 9 16 25))
(define odds (list 1 3 5 7))
#;(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
#;(define (length items)
  (define (iter items result)
    (if (null? items)
        result
        (iter (cdr items) (+ 1 result))))
  (iter items 0))

#;(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (last-pair list)
  (if (null? (cdr list))
      list
      (last-pair (cdr list))))

#;(define (reverse list)
  (define (reverse-iter list result)
    (if (null? list)
        result
        (reverse-iter (cdr list) (cons (car list) result))))
  (reverse-iter list (quote ())))
;try successive version of reverse but failed
#;(define (reverse list)
  (if (null?(cdr list))
      list
      (last-append (car list) (reverse (cdr list)))))
(define (last-append a list)
  (if (null? list)
      (cons a list)
      (cons (car list)
            (last-append a (cdr list)))))

(define us-coins (list 50 25 10 5 1))
(define (count-change amount coin-values)
  (cond
    ((= amount 0) 1)
    ((or (< amount 0) (no-more? coin-values)) 0)
    (else (+ (count-change (- amount (first-denomination coin-values)) coin-values)
             (count-change amount (except-first-denomination coin-values))))))
(define (no-more? coin-values)
  (null? coin-values))
(define (first-denomination coin-values)
  (car coin-values))
(define (except-first-denomination coin-values)
  (cdr coin-values))

; dotted-tail notation to define a function with arbitrary numbers of arguments
(define (same-parity . w)
  (if (null? w)
      (error "no argument" 'same-parity)
      (same-parity-a (car w) w)))
(define (same-parity? x y)
  (or (and (even? x) (even? y))
      (and (odd? x) (odd? y))))
(define (same-parity-a a list)
  (if (null? list)
      (quote ())
      (if (same-parity? a (car list))
          (cons (car list)
                (same-parity-a a (cdr list)))
          (same-parity-a a (cdr list)))))

#;(define (scale-list items factor)
  (if (null? items)
      (quote ())
      (cons (* (car items) factor)
            (scale-list (cdr items) factor))))

;higher order abstraction map procedures to list
#;(define (map proc list)
  (if (null? list)
      (quote ())
      (cons (proc (car list))
            (map proc (cdr list)))))
(define (scale-list items factor)
  (map (lambda (x) (* x factor)) items))

(define (square-list items)
  (map (lambda (x) (* x x)) items))


#;(define (square-list-1 items)
(define (iter things answer)
(if (null? things)
answer
(iter (cdr things)
(cons answer
(square (car things))))))
(iter items null))

#;(define (count-leaves x)
  (cond
    ((null? x) 0)
    ((pair? x)
     (+ (count-leaves (car x))
        (count-leaves (cdr x))))
    (else 1)))

(define (deep-reverse x)
  (cond
    ((null? x) x)
    ((not (pair? x)) x)
    ((and (null? (cdr x))
          (not (pair? (car x))))
     x)
    (else (last-append (deep-reverse (car x))
                       (deep-reverse (cdr x))))))

(define (fringe tree)
  (cond
    ((null? tree) null)
    ((leaf? tree) tree)
    ;((leaf? (car tree) (car tree)))
    (else (preserve-leaves (fringe (car tree)) (fringe (cdr tree))))))
(define (leaf? tree)
  (and (not (pair? tree))
       (not (null? tree))))
(define (preserve-leaves l1 l2)
  (cond
    ((and (leaf? l1) (leaf? l2)) (list l1 l2))
    ((and (leaf? l1) (null? l2)) (cons l1 l2))
    ((and (tree? l1) (null? l2)) (append l1 l2))
    ((and (leaf? l1) (tree? l2)) (cons l1 l2))
    ((and (tree? l1) (tree? l2)) (append l1 l2))))
(define (tree? tree)
  (pair? tree))
;(list-ref squares 3)

;compound data structure of binary mobile
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))
(define (total-weight mobile)
  (if (weight? mobile)
      mobile
      (let ((left-weight (total-weight (branch-structure (left-branch mobile))))
            (right-weight (total-weight (branch-structure (right-branch mobile)))))
        (+ left-weight right-weight))))
(define (weight? x)
  (and (not (null? x)) (not (pair? x))))

(define (balanced? mobile)
  (if (weight? mobile)
      #t
      (let ((left-branch-structure (branch-structure (left-branch mobile)))
            (right-branch-structure (branch-structure (right-branch mobile)))
            (left-branch-length (branch-length (left-branch mobile)))
            (right-branch-length (branch-length (right-branch mobile))))
        (and (balanced? left-branch-structure)
             (balanced? right-branch-structure)
             (= (* (total-weight left-branch-structure) left-branch-length)
                (* (total-weight right-branch-structure) right-branch-length))))))
; mapping over trees
#;(define (scale-tree tree factor)
  (cond
    ((null? tree) null)
    ((not (pair? tree)) (* tree factor))
    (else (cons (scale-tree (car tree) factor)
                (scale-tree (cdr tree) factor)))))
;regard tree as a sequences of subtrees and use map
(define (scale-tree tree factor)
  (map (lambda (subtree)
         (cond
           ((null? subtree) subtree)
           ((not (pair? subtree)) (* factor subtree))
           (else (scale-tree subtree factor))))
       tree))

#;(define (square-tree tree)
  (map (lambda (subtree)
         (cond
           ((null? subtree) null)
           ((not (pair? subtree)) (* subtree subtree))
           (else (square-tree subtree))))
       tree))
#;(define (square-tree tree)
  (cond
    ((null? tree) null)
    ((not (pair? tree)) (* tree tree))
    (else (cons (square-tree (car tree))
                (square-tree (cdr tree))))))

(define (tree-map proc tree)
  (cond
    ((null? tree) null)
    ((not (pair? tree)) (proc tree))
    (else (cons (tree-map proc (car tree))
                (tree-map proc (cdr tree))))))
(define (square-tree tree)
  (tree-map square tree))

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

;sequences as conventional interfaces
(define (sum-odd-squares tree)
  (cond
    ((null? tree) 0)
    ((not (pair? tree))
     (if (odd? tree) (square tree) 0))
    (else (+ (sum-odd-squares (car tree))
             (sum-odd-squares (cdr tree))))))
#;(define (even-fibs n)
  (define (next k)
    (if (> k n)
        null
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))
;sequence operation
;Organize programs to make the signal-flow structure manifest in the procedures we write
;If re represent signals as lists,we can use list operations to implement the processing
; at each of the stages.
(define (filter predicate sequence)
  (cond
    ((null? sequence) null)
    ((predicate (car sequence))
     (cons (car sequence)
           (filter predicate (cdr sequence))))
    (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
       (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;redefine some functions using accumulate method
#;(define (map proc sequence)
  (accumulate (lambda (x y) (cons (proc x) y)) null sequence))

(define (apped list1 list2)
  (accumulate cons list2 list1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low
            (enumerate-interval (+ low 1) high))))

(define (enumerate-leaves tree)
  (cond
    ((null? tree) null)
    ((not (pair? tree)) (list tree))
    (else (append (enumerate-leaves (car tree))
                  (enumerate-leaves (cdr tree))))))

(define (sum-odd-square tree)
  (define signal (enumerate-leaves tree))
  (define filter-signal (filter odd? signal))
  (define map-signal (map square filter-signal))
  (define accumulation (accumulate + 0 map-signal))
  accumulation)


(define (even-fibs n)
  (define signal (enumerate-interval 0 n))
  (define map-signal (map fib signal))
  (define filter-signal (filter even? map-signal))
  (define accumulation (accumulate cons null filter-signal))
  accumulation)

;Horner's rule algorithm evaluating polynomial

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))
;redefine count-leaves as accumulation

#;(define (count-leaves tree)
  (accumulate (lambda (x left) (+ 1 left))
              0
              (enumerate-leaves tree)))
;count-leaves with map and without enumerate-leaves
(define (count-leaves tree)
  (accumulate +
              0
              (map (lambda (node)
                     (cond
                       ((null? node) 0)
                       ((pair? node)
                        (count-leaves node))
                       (else 1)))
                   tree)))


(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (let ((first-elements (lambda (x)
                              (accumulate (lambda (e l)
                                            (cons (car e)
                                                  l))
                                          null
                                          x)))
            (left-seqs (lambda (x)
                         (accumulate (lambda (e l)
                                       (cons (cdr e)
                                             l))
                                     null
                                     x))))
        (cons (accumulate op init (first-elements seqs))
              (accumulate-n op init (left-seqs seqs))))))
;trying to write a more general map but failed
#;(define (map proc . seqs)
  (define (map-help proc seqs)
  (if (null? (car seqs))
      null
      (let ((first-elements (lambda (x)
                              (accumulate (lambda (e l)
                                            (cons (car e)
                                                  l))
                                          null
                                          x)))
            (left-seqs (lambda (x)
                         (accumulate (lambda (e l)
                                       (cons (cdr e)
                                             l))
                                     null
                                     x))))
        (cons (apply proc (first-elements seqs))
              (map-help proc (left-seqs seqs))))))
  (map-help proc seqs))
;using sequences representation to build matrix.
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
(define (matrix-*-vector m v)
  (map (lambda (l)
         (dot-product v l)) m))
(define (transpose mat)
  (accumulate-n cons null mat))
(define (matrix-*-matrix m n)
  (let ((n-cols (transpose n)))
    (map (lambda (m-row)
           (matrix-*-vector n-cols m-row)) m)))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result
                  (car rest))
              (cdr rest))))
  (iter initial sequence))
(define fold-right accumulate)
;using fold-right and fold-left to rewrite reverse
#;(define (reverse sequence)
  (fold-right (lambda (x y)
                (append y (list x))) null sequence))

(define (reverse sequence)
  (fold-left (lambda (r e)
                (cons e r)) null sequence))

;extend sequence paradigm to include nested loops

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))
(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j)
                    (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (define list-enumerator (unique-pairs n))
  (filter prime-sum? list-enumerator))
;using nested mapping generating permutations
(define (permutations s)
  (if (null? s)
      (list s)
      (flatmap (lambda (e)
                 (map (lambda (p)
                        (cons e p))
                      (permutations (remove e s))))
               s)))
(define (remove x s)
  (filter (lambda (e) (not (= x e))) s))

(define (unique-triples n)
  (flatmap (lambda (pair)
             (let ((i (car pair))
                   (j (cadr pair)))
               (map (lambda (k)
                      (list i j k))
                    (enumerate-interval 1 (- j 1)))))
           (unique-pairs n)))
 (define (queen-cols k board-size)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap              ;add kth-queen positionto whole sequence
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1) board-size)))))
(define (queens board-size)
 
  (map reverse (queen-cols board-size board-size)))

(define empty-board null)
(define (safe? k position)
  (if (= k 1)
      true
      (let ((check-row (car (car position)))
            (rest (cdr position)))
        (safe-check? 1 check-row rest))))
(define (safe-check? k check-row rest)
  (if (null? rest)
      true
      (let ((next (caar rest)))
        (and (not (or (= check-row next)
                      (= (abs (- next check-row)) k)))
             (safe-check? (+ k 1) check-row (cdr rest))))))
(define (adjoin-position new-row k rest-of-queens)
  (cons (list new-row k) rest-of-queens))

;picture language illustrate the power of data abstraction and closure.

;(define wave2 (besides wave (flip-vert wave)))
;(define wave4 (below wave2 wave2))
;transforming and combining painters
(define (transform painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame new-origin
                             (sub-vect (m corner1) new-origin)
                             (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
    (transform painter
               (make-vect 0 1)
               (make-vect 1 0)
               (make-vect 0 0)))

(define (flip-horiz painter)
    (transform painter
               (make-vect 1 0)
               (make-vect 0 0)
               (make-vect 1 1)))
(define rotate-180 flip-vert)

(define (beside painter1 painter2)
  (lambda (frame)
    ((transform painter1
                (make-vect 0 0)
                (make-vect 0.5 0)
                (make-vect 0 1)) frame)
    ((transform painter2
                (make-vect 0.5 0)
                (make-vect 1 0)
                (make-vect 0.5 1)) frame)))

(define (below painter1 painter2)
  (lambda (frame)
    ((transform painter1
                (make-vect 0 0)
                (make-vect 1 0)
                (make-vect 0 0.5)) frame)
    ((transform painter2
                (make-vect 0 0.5)
                (make-vect 1 0.5)
                (make-vect 0 1)) frame)))



#;(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))
;(define wave4 (flipped-pairs wave))

(define (right-split-n painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split-n painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split-n painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split-n painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (corner-split-n painter n)
  (if (= n 0)
      painter
      (let ((up (up-split-n painter (- n 1)))
            (right (right-split-n painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split-n painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

;higher order operations
#;(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (flipped-pairs painter)
  (let ((combine4 (square-of-four identity flip-vert identity flip-vert)))
    (combine4 painter)))

(define (square-limit painter n)
  (let ((quarter (corner-split-n painter n)))
    (let ((combine4 (square-of-four flip-horiz identity rotate-180 flip-vert)))
      (combine4 quarter))))

(define (split-n first-split second-split)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split-n first-split second-split) painter (- n 1))))
          (first-split painter (second-split smaller smaller))))))

(define (split first-split second-split)
  (lambda (painter)
    (first-split painter (second-split painter painter))))
(define right-split (split beside below))
(define up-split (split below beside))
;frame three vector,origin vector and 2 edge vectors
; using pairs to represent vector

(define (make-vect x y)
  (cons x y))
(define (xcor-vect a)
  (car a))
(define (ycor-vect a)
  (cdr a))
(define (add-vect a b)
  (make-vect (+ (xcor-vect a) (xcor-vect b))
             (+ (ycor-vect a) (ycor-vect b))))

(define (sub-vect a b)
  (make-vect (- (xcor-vect a) (xcor-vect b))
             (- (ycor-vect a) (ycor-vect b))))

(define (scale-vect scale v)
  (make-vect (* scale (xcor-vect v))
             (* scale (ycor-vect v))))

;frame coordinate map
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
               (scale-vect (ycor-vect v) (edge2-frame frame))))))

;constructors and selectors of frame
#|(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (cadr frame))
(define (edge2-frame frame)
  (caddr frame)) |#

(define (make-frame origin edge1 edge2)
  (cons origin
        (cons edge1 edge2)))
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (cadr frame))
(define (edge2-frame frame)
  (cddr frame))

;representation of segment
(define (make-segment start-point end-point)
  (cons start-point end-point))
(define (start-segment s)
  (car s))
(define (end-segment s)
  (cdr s))

;painter procedural representation of painter
#|
(open-graphics)
(define vp (open-viewport "A Picture Language" 500 500))

(define draw (draw-viewport vp))
(define (clear) ((clear-viewport vp)))
(define line (draw-line vp))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (let ((start-coord-map ((frame-coord-map frame) (start-segment segment)))
             (end-coord-map ((frame-coord-map frame) (end-segment segment))))
         (line
          (make-posn (xcor-vect start-coord-map) (ycor-vect start-coord-map))
          (make-posn (xcor-vect end-coord-map) (ycor-vect end-coord-map)))))
     segment-list)))

(define (frame-outline->painter frame)
  (let ((origin (make-vect 0.1 0.1))
        (c1 (make-vect 0.9 0.1))
        (c2 (make-vect 0.1 0.9))
        (c3 (make-vect 0.9 0.9)))
    (let ((segment-list (list (make-segment origin c1)
                              (make-segment origin c2)
                              (make-segment c1 c3)
                              (make-segment c2 c3))))
      ((segments->painter segment-list) frame))))

(define (frame-opposite-x->painter frame)
  (let ((origin (make-vect 0.1 0.1))
        (c1 (make-vect 0.9 0.1))
        (c2 (make-vect 0.1 0.9))
        (c3 (make-vect 0.9 0.9)))
    (let ((segment-list (list (make-segment origin c3)
                              (make-segment c1 c2))))
      ((segments->painter segment-list) frame))))
(define (frame-diamond->painter frame)
  (let ((origin (make-vect 0.1 0.1))
        (c1 (make-vect 0.9 0.1))
        (c2 (make-vect 0.1 0.9))
        (c3 (make-vect 0.9 0.9)))
    (let ((m-e1 (scale-vect 0.5 (add-vect origin c1)))
          (m-e2 (scale-vect 0.5 (add-vect origin c2)))
          (m-e3 (scale-vect 0.5 (add-vect c2 c3)))
          (m-e4 (scale-vect 0.5 (add-vect c1 c3))))
      (let ((segment-list (list (make-segment m-e1 m-e2)
                                (make-segment m-e2 m-e3)
                                (make-segment m-e3 m-e4)
                                (make-segment m-e4 m-e1))))
        ((segments->painter segment-list) frame)))))

(define wave-painter
  (segments->painter
   (list
    (make-segment (make-vect 0.5 0.4) ;;; leg triangle
                  (make-vect 0.6 0))
    (make-segment (make-vect 0.5 0.4)
                  (make-vect 0.4 0))
    (make-segment (make-vect 0.3 0)
                  (make-vect 0.35 0.4))
    (make-segment (make-vect 0.35 0.4)
                  (make-vect 0.3 0.7))
    (make-segment (make-vect 0.3 0.7)
                  (make-vect 0.2 0.6))
    (make-segment (make-vect 0.2 0.6)
                  (make-vect 0 0.8))
    (make-segment (make-vect 0 0.9)
                  (make-vect 0.2 0.7))
    (make-segment (make-vect 0.2 0.7)
                  (make-vect 0.3 0.75))
    (make-segment (make-vect 0.3 0.75)
                  (make-vect 0.4 0.75))
    (make-segment (make-vect 0.4 0.75)
                  (make-vect 0.35 0.9))
    (make-segment (make-vect 0.35 0.9)
                  (make-vect 0.4 1))
    (make-segment (make-vect 0.4 0.85) ;mouth
                  (make-vect 0.45 0.8))
    (make-segment (make-vect 0.45 0.8) ;mouth
                  (make-vect 0.5 0.85))
    (make-segment (make-vect 0.5 1)
                  (make-vect 0.55 0.9))
    (make-segment (make-vect 0.55 0.9) ;right face
                  (make-vect 0.5 0.75))
    (make-segment (make-vect 0.5 0.75) ;right shoulder
                  (make-vect 0.6 0.75))
    (make-segment (make-vect 0.6 0.75) ;right-side up 
                  (make-vect 1 0.45))
    (make-segment (make-vect 1 0.3) ;right-hand
                  (make-vect 0.6 0.5))
    (make-segment (make-vect 0.6 0.5)
                  (make-vect 0.7 0)))))


;test
(define v1 (make-vect 0 0))
(define v2 (make-vect 1 1))
(define s1 (make-segment v1 v2))
(define s-list (list s1))



|#
;(define unit-frame (make-frame (make-vect 0 500) (make-vect 500 0) (make-vect 0 -500)))
;(frame-outline->painter unit-frame)
;(frame-opposite-x->painter unit-frame)
;(frame-diamond->painter unit-frame)

;(wave-painter unit-frame)
;((segments->painter s-list) unit-frame)
;(paint (square-limit einstein 2))
;(paint (flipped-pairs einstein))
;(paint (right-split einstein 2))
;(paint (right-split-n einstein 3))
;(paint (right-split-m einstein 3))
;(paint (up-split einstein 2))
;(paint (corner-split einstein 2))
;(queens 4)
(define list2 '(1 2 3))
;(unique-pairs 5)
;(unique-triples 5)
;(permutations list2)
;(prime-sum-pairs 5)
;(reverse list2)
;(fold-left / 1 list2)
;(fold-right / 1 list2)
;(fold-left list null list2)
;(fold-right list null list2)
;(horner-eval 2 list2)
;(filter odd? list2)
;(accumulate + 0 list2)
;(even-fibs 10)

;(subsets '(1 2 3))
(define list1 (list 2 (list 2 (list 1 (list 3 4) 4 4 4 6 4))))
(define list-a (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(define mobile1 (list (list 2 3) (list 3 2) (list 1 2)))
(define mobile2 (list (list 2 mobile1) (list 3 5)))
;(transpose list-a)
;(matrix-*-vector list-a (list 1 2 3))
;(matrix-*-matrix list-a mobile1)
;(accumulate-n + 0 list-a)
;(map * (list 1 2) (list 3 4))
;(count-leaves list1)
;;(sum-odd-square list1)
;(sum-odd-squares list1)

;(square-tree list1)
;(scale-tree list1 10)
;(total-weight mobile1)
;(total-weight mobile2)
;(balanced? mobile1)
;(balanced? mobile2)