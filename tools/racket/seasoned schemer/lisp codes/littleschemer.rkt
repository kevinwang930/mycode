#lang racket


(define atom? 
(lambda (x) 
(and (not (pair? x))  (not (null? x)))))

(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (equal? a (car lat))
                (member? a (cdr lat)))))))

;(lat? (quote (a b (c))))


(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else (cons (car (car l)) (firsts (cdr l)))))))

(define seconds              ;this function must apply to list of at least 2 pairs.
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else (cons (car (cdr (car l)))
                  (seconds (cdr l)))))))

;(seconds '((1 2) (3 4)))
(define insertL
  (lambda (new old lat)
   (cond
    ((null? lat) (quote ()))
    (else (cond
            ((eq? (car lat) old) (cons new lat))
            (else (cons (car lat) (insertL new old (cdr lat)))))))))
;(insertL 'delicious 'meat '(rice and poke meat and beaf meat))

(define insertR
  (lambda (new old lat)
   (cond
    ((null? lat) (quote ()))
    (else (cond
            ((eq? (car lat) old) (cons old (cons new (cdr lat))))
            (else (cons (car lat) (insertR new old (cdr lat)))))))))

(define subst
  (lambda (new old lat)
          (cond
            ((null? lat) (quote ()))
            (else
             (cond
               ((eq? (car lat) old) (cons new (cdr lat)))
               (else (cons (car lat) (subst new old (cdr lat)))))))))
;(subst 'beef 'meat '(rice and meat and meat))
(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) (quote ()))
      (else
       (cond
         ((or (eq? (car lat) o1) (eq? (car lat) o2)) (cons new
                                   (cdr lat)))
         (else (cons (car lat) (subst2 new o1 o2 (cdr lat)))))))))

;(subst2  'meat 'pork 'beef '(rice and beef pork beef))
;(define test
; (lambda (a b c)
;    (cond
;      ((eq? a 2) 'first)
;      ((eq? b 2) 'second)
;      (else 'third))))
;(test 2 2 2)
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((equal? (car lat) a) (multirember a (cdr lat)))
      (else (cons (car lat)
                  (multirember a (cdr lat)))))))

;(multirember 'meat '(beef meat and pork meat are all meat))
(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old) (cons old
                                 (cons new
                                      (multiinsertR new old (cdr lat)))))
      (else (cons (car lat)
                  (multiinsertR new old (cdr lat)))))))
;(multiinsertR 'delicious 'meat '(rice and poke meat and beaf meat))

(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old) (cons new
                                 (cons old
                                      (multiinsertL new old (cdr lat)))))
      (else (cons (car lat)
                  (multiinsertL new old (cdr lat)))))))
;(multiinsertL 'fried 'fish '(chips and fish or fish and fried))
(define multisubst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons new
             (multisubst new old
                         (cdr lat))))
      (else (cons (car lat)
                  (multisubst new old
                              (cdr lat)))))))
;(multisubst 'meat 'beef '(beef and delicious beef))
(define add1
  (lambda (n)
    (+ n 1)))
;(add1 46)
(define sub1
  (lambda (n)
    (- n 1)))
;(sub1 47)
(define o+
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (o+ (add1 n) (sub1 m))))))

(define o-
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (o- (sub1 n) (sub1 m))))))

(define addup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (o+ (car tup)
                (addup (cdr tup)))))))
;(addup '(1 2 3 4 5))
(define o*
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else (o+ n
                (o* n (sub1 m)))))))
;(o* 3 4)

(define tup+
  (lambda (tup1 tup2)
  (cond
    ((null? tup1) tup2)
    ((null? tup2) tup1)
    (else (cons (o+ (car tup1) (car tup2))
                (tup+ (cdr tup1) (cdr tup2)))))))
;(tup+ '(1 2 3) '(4 5 6 7 5 6 7 8 9))
(define o>
  (lambda (n m)
    (cond
      ((and (zero? m) (zero? n)) #f)
      ((zero? n) #f)
      ((zero? m) #t)
      (else (o> (sub1 n) (sub1 m))))))

(define o<
  (lambda (n m)
    (cond
      ((and (zero? m) (zero? n)) #f)
      ((zero? m) #f)
      ((zero? n) #t)
      (else (o< (sub1 n) (sub1 m))))))

(define o=
  (lambda (n m)
    (cond
      ((and (zero? m) (zero? n)) #t)
      ((zero? m) #f)
      ((zero? n) #f)
      (else (o= (sub1 n) (sub1 m))))))
;(o< 1 2)
;(o= 34 34)

(define o^
  (lambda (n m)
    (cond
      ((o= m 0) 1)
      (else (o* n
                (o^ n (sub1 m)))))))
;(o^ 2 3)

(define o/
  (lambda (n m)
    (cond
      ((o< n m) 0)
      (else (add1 (o/ (- n m) m))))))

;(o/ 100 2)
(define olength
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (olength (cdr lat)))))))
;(olength '(1 2 3))

(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

;(pick 4 '(rice and meat is very dilicious))


(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat)) (no-nums (cdr lat)))
      (else (cons (car lat)
                  (no-nums (cdr lat)))))))
;(no-nums '(1 2 3 meat delicious))

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat)) (cons (car lat)
                                 (all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))
;(all-nums '(1 2 3 meat delicious))

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (o= a1 a2))
      ((or (number? a1) (number? a2)) #f)
      (else (eq? a1 a2)))))
;(eqan? 2 2)

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eqan? (car lat) a) (add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))
;(occur 1 '(23 4 1 1 4 1))
(define one?
  (lambda (a)
   (o= a 1)))
;(one? 1)

(define rempick
  (lambda (n lat)
    (cond
      ((one? n) (cdr lat))
      (else (cons (car lat)
                  (rempick (sub1 n) (cdr lat)))))))
;(rempick 4 '(rice and meat is very dilicious))

(define rember*
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((atom? (car lat))
       (cond
         ((eqan? (car lat) a) (rember* a
                                       (cdr lat)))
         (else (cons (car lat)
                     (rember* a (cdr lat))))))
      (else (cons (rember* a (car lat))
                  (rember* a (cdr lat)))))))
;(rember* 'meat '((rice and meat) (pork meat) meat rice))

(define insert*
  (lambda (a b lat)
    (cond
      ((null? lat) (quote ()))
      ((atom? (car lat))
       (cond
         ((eqan? (car lat) b) (cons b (cons a
                                            (insert* a b
                                                     (cdr lat)))))
         (else (cons (car lat)
                     (insert* a b
                              (cdr lat))))))
      (else (cons (insert* a b (car lat))
                  (insert* a b (cdr lat)))))))


(define lat
  '((how much (wood)) 
could
((a (wood) chuck))
(((chuck))) 
(if (a) ((wood chuck))) 
could chuck wood)) 
;(insert* 'chuck 'wood lat)
(define occur*
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((atom? (car l)) (cond
                         ((eqan? (car l) a) (add1 (occur* a (cdr l))))
                         (else (occur* a (cdr l)))))
      (else (o+ (occur* a (car l))
                (occur* a (cdr l)))))))
;(occur* 'wood lat)
(define subst*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l)) (cond
                         ((eqan? (car l) old) (cons new
                                                    (subst* new old (cdr l))))
                         (else (cons (car l)
                                     (subst* new old (cdr l))))))
      (else (cons (subst* new old (car l))
                (subst* new old (cdr l)))))))
;(subst* 'forest 'wood lat)

(define insertL*
  (lambda (a b lat)
    (cond
      ((null? lat) (quote ()))
      ((atom? (car lat))
       (cond
         ((eqan? (car lat) b) (cons a (cons b
                                            (insertL* a b
                                                     (cdr lat)))))
         (else (cons (car lat)
                     (insertL* a b
                              (cdr lat))))))
      (else (cons (insertL* a b (car lat))
                  (insertL* a b (cdr lat)))))))
;(insertL* 'forest 'wood lat)
(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l)) (cond
                         ((eqan? (car l) a) #t)
                         (else (member* a (cdr l)))))
      (else (or (member* a (car l))
                (member* a (cdr l)))))))
;(member* 'a lat)

(define leftmost
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l)) (car l))
      
      (else (leftmost (car l))))))
;(leftmost lat)

(define equal?
  (lambda (s1 s2)
    (cond
      ((and (null? s1)
            (null? s2)) #t)
      ((or (null? s1)
            (null? s2)) #f)
      ((and (atom? s1)
            (atom? s2)) (eqan? s1 s2))
      ((or (atom? s1)
           (atom? s2)) #f)
      (else (and (equal? (car s1) (car s2))
                 (equal? (cdr s1) (cdr s2)))))))
;(equal? '(1 2) '(1 2))

(define rember
  (lambda (s l)
    (cond
      ((null? l) (quote ()))
      ((equal? s (car l)) (rember s (cdr l)))
      (else (cons (car l) (rember s (cdr l)))))))

;(rember '(pork meat) '((pork meat) potato banana meat))

(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      ((or (eq? (car aexp) (quote +))
           (eq? (car aexp) (quote *))
           (eq? (car aexp) (quote ^))) (and (number? (car (cdr aexp)))
                                            (number? (car (cdr (cdr aexp))))))
       (else (quote (not a arithmatic expression))))))
;(numbered? '(- 1 2))

(define operator
  (lambda (aexp)
    (car aexp)))
(define 1st-subexp
  (lambda (aexp)
    (car (cdr aexp))))
(define 2nd-subexp
  (lambda (aexp)
    (car (cdr (cdr aexp)))))
(define value
  (lambda (aexp)
    (cond
       ((atom? aexp) aexp)
       ((eq? (operator aexp) (quote +)) (o+ (value (1st-subexp aexp))
                                            (value (2nd-subexp aexp))))
       ((eq? (operator aexp) (quote *)) (o* (value (1st-subexp aexp))
                                            (value (2nd-subexp aexp))))
       
       
       ((eq? (operator aexp) (quote ^)) (o^ (value (1st-subexp aexp))
                                            (value (2nd-subexp aexp))))
       )))

;(value '(+ 2 (+ 2 4)))

(define set?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((member? (car l) (cdr l)) #f)
      (else (set? (cdr l))))))

;(set? '(1 2 apple apple 3))

(define makeset
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      (else (cons (car lat)
                  (makeset (rember (car lat) (cdr lat))))))))
;(makeset '(apple 1 2 1 1 1 apple sweat apple))

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      ((member? (car set1) set2) (subset? (cdr set1) set2))
      (else #f))))

;(subset? '(1) '(1 2))

(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2) (subset? set2 set1))))   ;this definition does not calculate duplicated atom

;(eqset? '(1 2) '(1 1 2))

(define intersect?
  (lambda (set1 set2)
    
    (cond
      ((null? set1) #f)
      (else (or (member? (car set1) set2) 
                (intersect? (cdr set1) set2))))))

;(intersect? '(wang) '(wang yong))

(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) (quote ()))
      ((member? (car set1) set2) (cons (car set1)
                                          (intersect (cdr set1) set2)))
      (else (intersect (cdr set1) set2)))))

;(intersect '(my name is kevin) '(kevin is very good))

(define union
  (lambda (set1 set2)
    (cond
      ((null? set1) set2)
      ((member? (car set1) set2) (union (cdr set1) set2))
      (else (cons (car set1) (union (cdr set1) set2))))))

;(union '(kevin is who) '(my name is kevin))

(define xxx
  (lambda (set1 set2)
    (cond
      ((null? set1) (quote ()))
      ((member? (car set1) set2) (xxx (cdr set1) set2))
      (else (cons (car set1)
                  (xxx (cdr set1) set2))))))

;(xxx '(kevin is my name) '(I want to check if that is ok))

(define intersectall
  (lambda (l-set)
    (cond
      ((null? l-set) (quote ()))
      ((null? (cdr l-set)) (car l-set))
      (else (intersect (car l-set)
                       (intersectall (cdr l-set)))))))
;(intersectall '((my name is kevin) (who is kevin) (kevin will go hospital tomorrow)))

(define a-pair?
  (lambda (x)
    (cond
      ((atom? x) #f)
      ((null? x) #f)
      ((null? (cdr x)) #f)
      ((null? (cdr (cdr x))) #t)
      (else #f))))

;(a-pair? '3)


(define first
  (lambda (p)
    (car p)))
;(first '(kevin 3 4))

(define second
  (lambda (p)
    (car (cdr p))))

(define third
  (lambda (p)
    (car (cdr (cdr p)))))

(define build
  (lambda (s1 s2)
    (cons s1
          (cons s2 (quote ())))))

;(build '1 '2)

(define rel?     ;rel means relation, set of pairs.
  (lambda (l)
    (cond
      ((a-pair? (car l)) (rel? (cdr l)))
      (else #F))))

;(rel? '())

(define fun?               ;check if the firsts of l is a set
  (lambda (l)
    (set? (firsts l))))

;(fun? '((1 2) (3 4) (7 8) (kevin wang)))


(define revrel
  (lambda (x)
    (cond
      ((null? x) (quote ()))
      (else (cons (build (second (car x))
                         (first (car x)))
                  (revrel (cdr x)))))))

;(revrel '((1 2) (kevin wang)))

(define revpair
  (lambda (pair)
    (cond
      ((a-pair? pair) (build (car (cdr pair))
                             (car pair)))
      (else (quote (not a pair))))))

;(revpair '((1 2) (kevin 3)))

(define fullfun?
  (lambda (fun)
    (set? (seconds fun))))

;(fullfun? (quote ((1 2) (2 4))))

(define rember-f
  (lambda (test?)
     (lambda (a l)
       
       (cond
         ((null? l) (quote ()))
         ((test? (car l) a) (cdr l))
         (else (cons (car l)
                     ((rember-f test?) a (cdr l))))))))

;((rember-f eq?) 'eq? '(eq? wang))

(define insertL-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) (quote ()))
        ((test? (car l) old) (cons new
                                 l))
        (else (cons (car l)
                    ((insertL-f test?) new old (cdr l))))))))

;((insertL-f >) 'kevin '1 '(1 2 3))

(define insertR-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) (quote ()))
        ((test? (car l) old) (cons (car l)
                                   (cons new
                                         (cdr l))))
        (else (cons (car l)
                    ((insertR-f test?) new old (cdr l))))))))

;((insertR-f >) 'kevin '1 '(1 2 3))



(define insert-g
  (lambda (seq)
    (lambda (new old l)
        (cond
          ((null? l) (quote ()))
          ((eq? (car l) old)  (seq new old (cdr l)))
          (else (cons (car l)
                      ((insert-g seq) new old (cdr l))))))))

#|(define seql
  (lambda (new old l)
    (cons new
          (cons old
                l))))
(define seqr
  (lambda (new old l)
    (cons old
          (cons new
                l))))|#

(define insertl-c
  (insert-g
    (lambda (new old l)
      (cons new
            (cons old
                  l)))))

(define insertr-c
  (insert-g
    (lambda (new old l)
      (cons old
            (cons new
                  l)))))

(define subset-c
  (insert-g
    (lambda (new old l)
       (cons new
             l))))



         

;(subset-c 'kevin '1 '(1 wang 3))

(define yyy                 ;this functin deletes one specific atom from list
 (lambda (a l)
    ((insert-g seqrem) #f a l)))

(define seqrem
  (lambda (new old l)
    l))

;(yyy 'sausage '(pizza with sausage and bacon))

(define atom-to-function
  (lambda (x)
    (cond
      ((eq? x (quote +)) o+)
      ((eq? x (quote *)) o*)
      (else o^))))

(define value-s
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      (else
        ((atom-to-function (operator nexp))
          (value-s (1st-subexp nexp))
          (value-s (2nd-subexp nexp)))))))

;(value-s '(+ 2 3))

(define multiremberT
  (lambda (test? lat)
    (cond
      ((null? lat) (quote ()))
      ((test? (car lat))
       (multiremberT test? (cdr lat)))
      (else (cons (car lat)
                  (multiremberT test? (cdr lat)))))))

(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a))))

(define eq?-tuna
  (eq?-c (quote tuna)))

;(multiremberT eq?-tuna '(tuna is a very good tuna tuna shrimp))


(define a-friend
  (lambda (x y)
    (null? y)))

(define new-friend
  (lambda (newlat seen)
    (a-friend newlat (cons (car lat)
                      seen))))

(define last-friend
  (lambda (x y)
    (length x)))

(define multirember-co
  (lambda (a lat col)
    (cond
      ((null? lat) (col (quote ()) (quote ())))
      ((eq? (car lat) a) (multirember-co a
                                         (cdr lat)
                                         (lambda (newlat seen)
                                           (col newlat
                                                (cons (car lat) seen)))))
      (else (multirember-co a
                            (cdr lat)
                            (lambda (newlat seen)
                              (col (cons (car lat) newlat)
                                   seen)))))))

;(multirember-co 'tuna '() a-friend)
;(multirember-co 'tuna '(tuna) a-friend)
;(multirember-co 'tuna '(and tuna) a-friend)
;(multirember-co 'tuna '(strawberries tuna and swordfish) last-friend)


(define multiinsertLR
  (lambda (new oldL oldR lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) oldL) (cons new
                                  (cons oldL
                                        (multiinsertLR new oldL oldR (cdr lat)))))
      ((eq? (car lat) oldR) (cons oldR
                                  (cons new
                                        (multiinsertLR new oldL oldR (cdr lat)))))
      (else (cons (car lat)
                  (multiinsertLR new oldL oldR (cdr lat)))))))

;(multiinsertLR 'test 'left 'right '(left or right I want test))

(define multiinsertLR-co
  (lambda (new oldL oldR lat col)
    (cond
      ((null? lat) (col (quote ()) 0 0))
      ((eq? (car lat) oldL) (multiinsertLR-co new oldL oldR (cdr lat)
                                                         (lambda (newlat L R)
                                                           (col (cons new
                                                                      (cons oldL newlat)) (add1 L) R))))
                                           
      ((eq? (car lat) oldR) (multiinsertLR-co new oldL oldR (cdr lat)
                                                         (lambda (newlat L R)
                                                           (col (cons oldR
                                                                      (cons new newlat)) L (add1 R)))))
      (else (cons (car lat)
                  (multiinsertLR-co new oldL oldR (cdr lat)
                                                  (lambda (newlat L R)
                                                    (col (cons (car lat) newlat) L R))))))))

(define output
  (lambda (x y z)
    (x)))

;(multiinsertLR-co 'salty 'fish 'chips '(chips and fish is delicious) output)

(define even?
  (lambda (n)
    (cond
      ((= n 0) #t)
      ((> n 2) (even? (sub1 (sub1 n))))
      ((= n 2) #t)
      (else #f))))

(define evens-only*
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l)) (cond
                         ((even? (car l)) (cons (car l)
                                                (evens-only* (cdr l))))
                         (else (evens-only* (cdr l)))))
      (else (cons (evens-only* (car l))
                  (evens-only* (cdr l)))))))

;(even? '16451)

;(evens-only* '((9 1 2 8) 3 10 ((9 9) 7 6) 2))

(define evens-only*-co
  (lambda (l col)
    (cond
      ((null? l)    (col (quote ()) '1 '0))
      ((atom? (car l)) (cond
                         ((even? (car l)) (evens-only*-co (cdr l)
                                                          (lambda (newl evenmulti oddplus)
                                                            (col (cons (car l) newl) (o* (car l) evenmulti) oddplus))))
                         (else (evens-only*-co (cdr l)
                                               (lambda (newl evenmulti oddplus)
                                                 (col newl evenmulti (o+ oddplus (car l))))))))
      (else (evens-only*-co (car l)
                            (lambda (al ap as)
                              (evens-only*-co (cdr l)
                                              (lambda (dl dp ds)
                                                (col (cons al dl)
                                                     (o* ap dp)
                                                     (o+ as ds))))))))))
              

(define three-cons-friend
  (lambda (l p s)
    p))

(define samplel
  '((9 1 2 8) 3 10 ((9 9) 7 6) 2))

;(evens-only*-co samplel three-cons-friend)

(define looking                   ;partial function, seems strange
  (lambda (a lat)
    (keep-looking a (pick 1 lat) lat)))

(define keep-looking
  (lambda (a sorn lat)
    (cond
      ((number? sorn) (keep-looking a (pick sorn lat) lat))
      (else (equal? sorn a)))))

;(looking 'kevin '(2 4 8 3 kevin wang 3 5 1))

(define shift
  (lambda (pair)
    (build (first (first pair))
           (build (second (first pair))
                  (second pair)))))

;(shift '((a b) (c d)))

(define align
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora)) (align (shift pora)))
      (else (build (first pora)
                   (align (second pora)))))))


;(align '((a b e f) (c d)))

;(align '((3 4) (1 2)))

(define length*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else (o+ (length* (first pora))
                (length* (second pora)))))))

;(length* '((3 4) (1 2)))

(define weight*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else (o+ (o* (weight* (first pora)) 2)
                (weight* (second pora)))))))

;(weight* '((a b) c))
;(weight* '(a (b c)))

(define shuffle
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora)) (shuffle (revpair pora)))
      (else (build (first pora)
                   (shuffle (second pora)))))))

;(shuffle '((3 4) 1))

(define C
  (lambda (n)
    (cond
      ((one? n) 1)
      ((even? n) (C (o/ n 2)))
      (else (C (add1 (o* n 3)))))))

;(C '4)

(define A
  (lambda (n m)
    (cond
      ((zero? n) (add1 m))
      ((zero? m) (A (sub1 n) (add1 m)))
      (else (A (sub1 n)
               (A n (sub1 m)))))))

;(A '1 '2)

(define eternity
 (lambda (x)
  (eternity x)))

;(define last-try
;  ((lambda (x)
;     (and (will-stop? last-try)
;          (eternity x)))))

(define length0
  (lambda (l)
  (cond
    ((null? l) 0)
    (else (add1
           (eternity (cdr l)))))))

(length0 '())


(define length2
  (lambda (l)
  (cond
    ((null? l) 0)
    (else (add1
           ((lambda (l)
             (cond
               ((null? l) 0)
               (else (add1 ((lambda (l)
                              (cond
                               ((null? l) 0)
                               (else (add1 (eternity (cdr l))))))
                            (cdr l))))))
            (cdr l)))))))

(length2 '(1 2))

(((lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l)))))))
  eternity) '())


(((lambda (f)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (f (cdr l)))))))
((lambda (g)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (g l))))))
eternity)) '(1))

([(lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))
 ((lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))
  ((lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))
   eternity))] '(1 2))

[((lambda (mk-length)                     ;length0
  (mk-length eternity))
 (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))) '()]

[((lambda (mk-length)                     ;length1
  (mk-length
   (mk-length eternity)))
 (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))) '(1)]

[((lambda (mk-length)                     ;length2
  (mk-length
   (mk-length
    (mk-length eternity))))
 (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))) '(1 2)]

[((lambda (mk-length)                     ;length0
  (mk-length mk-length))
 (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))) '()]  

[((lambda (mk-length)                     ;length2    lambda can start a procedure
  (mk-length
   (mk-length
    (mk-length mk-length))))
 (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))) '(1 2)]

[((lambda (mk-length)                     ;length1, change length to mk-length to see the result.
  (mk-length mk-length))
 (lambda (mk-length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 ((mk-length eternity) (cdr l)))))))) '(1)]

#;[((lambda (mk-length)                     ;length1, change length to mk-length to see the result.
  (mk-length mk-length))
 (lambda (mk-length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 ((mk-length mk-length) (cdr l)))))))) '(1 2 3 4 5 6 7)];#



#;(((lambda (mk-length)
    (mk-length mk-length))
  (lambda (mk-length)
    ((lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length (cdr l)))))))
    (mk-length mk-length)))) '(1 2 3 4));#

#;[((lambda (mk-length)                   ;problem of this procedure is that length may not return a function.
  ((lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l)))))))
    (mk-length mk-length)))
(lambda (mk-length)
  ((lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l)))))))
    (mk-length mk-length)))) '(1 2 3)] ;#



#;[((lambda (mk-length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 ((mk-length mk-length) (cdr l)))))))
(lambda (mk-length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 ((mk-length mk-length) (cdr l)))))))) '(1 2 3 4)];#

#;[((lambda (mk-length)
  (mk-length mk-length))
 (lambda (mk-length)
   ((lambda (length)
     (lambda (l)
      (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))
   (lambda (x)
     ((mk-length mk-length) x))))) '(1 2 3 4 5 6)];#

#;[[(lambda (le)
  [(lambda (mk-length)
    (mk-length mk-length))
   (lambda (mk-length)
     (le (lambda (x)
           ((mk-length mk-length) x))))])
 (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))] '(wang yong)];#


#;(((lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))
(lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))) '());#
#;(((lambda (mk-length)
  (mk-length mk-length))
  (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))) '());#

#;(((lambda (mk-length)
  (mk-length
   (mk-length mk-length)))
  (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))) '(1));#

#;(((lambda (mk-length)
  (mk-length
   (mk-length
    (mk-length mk-length))))
  (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))) '(1 2));#

(((lambda (mk-length)
  (mk-length mk-length))
  (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 ((length length) (cdr l)))))))) '(1 2 3 4 5))

(((lambda (mk-length)             
  (mk-length mk-length))

 (lambda (mk-length)
   ((lambda (length)
     (lambda (l)
       (cond
         ((null? l) 0)
         (else (add1 (length (cdr l)))))))
    (lambda (x)
      ((mk-length mk-length) x)))
 )) '(6 5 wabg ibg 7 8 9))

(((lambda (le)                                      ;where does le come from
   ((lambda (mk-length)              
  (mk-length mk-length))

 (lambda (mk-length)
   (le
    (lambda (x)
      ((mk-length mk-length) x))))))
 (lambda (length)
     (lambda (l)
       (cond
         ((null? l) 0)
         (else (add1 (length (cdr l)))))))) '(1 2 3 4 5))

(define Y
  (lambda (le)
    (lambda (f) (f f))
    (lambda (f)
      (le (lambda (x) ((f f) x))))))

(define new-entry build)
(define entry1 (new-entry '(kevin alex hannah) '(male male female)))
(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help name
                          (first entry)
                          (second entry)
                          entry-f)))

(define lookup-in-entry-help
  (lambda (name names values entry-f)
    (cond
      ((null? names) entry-f)
      ((eq? (car names) name)
       (car values))
      (else (lookup-in-entry-help name
                                  (cdr names)
                                  (cdr values)
                                  entry-f)))))

(define extend-table cons)

(define entry2 (new-entry '(amy yoyo joy) '(female female female)))
(define table1 '())
(define table2 (extend-table entry1 table1))
(define table3 (extend-table entry2 table2))

(define lookup-in-table
  (lambda (name table table-f)
    (cond
      ((null? table) (table-f name))
      (else (lookup-in-entry name
                             (car table)
                             (lambda (name)
                               (lookup-in-table name (cdr table) table-f)))))))

(define expression-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else (list-to-action e)))))

(define atom-to-action
(lambda (e)
(cond
((number? e) *const)
((eq? e #t) *const)
((eq? e #f) *const)
((eq? e (quote cons)) *const)
((eq? e (quote car)) *const)
((eq? e (quote cdr)) *const)
((eq? e (quote null?)) *const)
((eq? e (quote eq?)) *const)
((eq? e (quote atom?)) *const)
((eq? e (quote zero?)) *const)
((eq? e (quote add1)) *const)
((eq? e (quote sub1)) *const)
((eq? e (quote number?)) *const)
(else *identifier))))

(define list-to-action
  (lambda (e)
    (cond
      ((atom? (car e))
       (cond
         ((eq? (car e) (quote quote))
          *quote)
         ((eq? (car e) (quote lambda))
          *lambda)
         ((eq? (car e) (quote cond))
          *cond)
         (else *application)))
      (else *application))))

(define ivalue
  (lambda (e)
    (meaning e (quote ()))))
(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))

(define *const
  (lambda (e table)
    (cond
      ((number? e) e)
      ((eq? e #t) #t)
      ((eq? e #f) #f)
      (else (build (quote primitive) e)))))

(define *quote
  (lambda (e table)
    (text-of e)))

(define text-of second)

(define *identifier
  (lambda (e table)
    (lookup-in-table e table initial-table)))

(define initial-table
  (lambda (name)
    (car (quote ()))))

(define *lambda
  (lambda (e table)
    (build (quote non-primitive)
           (cons table (cdr e)))))

(define table-of first)
(define formulas-of second)
(define body-of third)

(define evcon
  (lambda (lines table)
    (cond
      ((else? (question-of (car lines)))
       (meaning (answer-of (car lines)) table))
      ((meaning (question-of (car lines)) table)
       (meaning (answer-of (car lines)) table))
      (else (evcon (cdr lines) table)))))

(define question-of first)
(define answer-of second)

(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)))

(define cond-lines-of cdr)
(define else?
  (lambda (a)
    (cond
      ((atom? a) ((eq? a (quote else)) #t))
      (else #f))))
(define avlis
  (lambda (args table)
    (cond
      ((null? args) (quote ()))
      (else
       (cons (meaning (car args) table)
             (avlis (cdr args) table))))))
(define *application
  (lambda (e table)
    (apply
     (meaning (function-of e) table)
     (avlis (arguments-of e) table))))
(define function-of car)
(define arguments-of cdr)

(define primitive?
  (lambda (l)
    (eq? (first l) (quote primitive))))
(define non-primitive?
  (lambda (l)
    (eq? (first l) (quote non-primitive))))
(define apply
  (lambda (fun vals)
    (cond
      ((primitive? fun)
       (apply-primitive (second fun) vals))
      ((non-primitive? fun)
       (apply-closure (second fun) vals)))))
(define apply-primitive
  (lambda (name vals)
    ((eq? name (quote cons))
     (cons (first vals) (second vals)))
    ((eq? name (quote car))
     (car (first vals)))
    ((eq? name (quote cdr))
     (cdr (first vals)))
    ((eq? name (quote null?))
     (null? (first vals)))
    ((eq? name (quote eq?))
     (eq? (first vals) (second vals)))
    ((eq? name (quote atom?))
     (:atom? (first vals)))
    ((eq? name (quote zero?))
     (zero? (first vals)))
    ((eq? name (quote add1))
     (add1 (first vals)))
    ((eq? name (quote sub1))
     (sub1 (first vals)))
    ((eq? name (quote number?))
     (number? (first vals)))))
(define :atom?
  (lambda (x)
    (cond
      ((atom? x) #t)
      ((null? x) #f)
      ((eq? (car x) (quote primitive)) #t)
      ((eq? (car x) (quote non-primitive)) #t)
      (else #f))))

(define apply-closure
  (lambda (closure vals)
    (meaning (body-of closure)
             (extend-table
              (new-entry
              (formulas-of closure)
              vals)
              (table-of closure)))))

;(ivalue (+ 1 2))













































































































