#lang eopl
(define error eopl:error)
(define-datatype bintree bintree?
  (leaf-node (num integer?))
  (interior-node (key symbol?)
                 (left bintree?)
                 (right bintree?)))
#|(define max-interior
  (lambda (tree)
    (caddr (max-tree-info tree))))
(define max-tree-info
  (lambda (tree)
    (cases bintree tree
      (leaf-node (num) num)
      (interior-node (key left right)
                     (let* ((L (max-tree-info left))
                            (R (max-tree-info right))
                            (Bintree-Info (Max-tree-info-helper L R key)))
                        Bintree-Info)))))
(define Max-tree-info-helper
  (lambda (left right key)
    (cond
      ((and (integer? left) (integer? right))
       (let* ((Sum (+ left right))
              (Max-sum Sum)
              (Max-key key))
         (list Sum Max-sum Max-key)))
      ((integer? left)
       (let* ((Sum (+ left (car right)))
              (Max-sum-and-key (max-sum-and-key (list Sum key) (cdr right))))
         (cons Sum Max-sum-and-key))))))
(define max-sum-and-key
  (lambda (L R)
    (if (> (car L) (car R))
        L
        R)))   |#

(define tree-1
  (interior-node 'foo (leaf-node 2) (leaf-node 3)))

(define tree-2
  (interior-node 'bar (leaf-node -1) tree-1))

(define tree-3
  (interior-node 'baz tree-2 (leaf-node 1)))



(define-datatype bintreeinfo bintreeinfo?
  (leaf-info (num integer?))
  (interior-info (sum integer?)
                 (max-sum integer?)
                 (max-key symbol?)))
(define max-interior
  (lambda (tree)
    (let ((Max-tree-info (max-tree-info tree)))
      (cases bintreeinfo Max-tree-info
        (leaf-info (num) (error 'max-interior "empty tree"))
        (interior-info (sum max-sum max-key) max-key)))))
(define max-tree-info
  (lambda (tree)
    (cases bintree tree
      (leaf-node (num) (leaf-info num))
      (interior-node (key left right)
                 (let* ((L (max-tree-info left))
                        (R (max-tree-info right)))
                   (cases bintreeinfo L
                     (leaf-info (numl)
                                (cases bintreeinfo R
                                  (leaf-info (numr)
                                             (let* ((Sum (+ numl numr))
                                                    (Max-sum Sum))
                                               (interior-info Sum
                                                              Max-sum
                                                              key)))
                                  (interior-info (sum max-sum max-key)
                                                 (let* ((Sum (+ numl sum))
                                                        (Max-sum-and-key (max-sum-and-key (list Sum key) (list max-sum max-key)))
                                                        (Max-sum (car Max-sum-and-key))
                                                        (Max-key (cadr Max-sum-and-key)))
                                                   (interior-info Sum
                                                                  Max-sum
                                                                  Max-key)))))
                     (interior-info (suml max-suml max-keyl)
                                    (cases bintreeinfo R
                                      (leaf-info (numr)
                                                 (let* ((Sum (+ suml numr))
                                                        (Max-sum-and-key (max-sum-and-key (list Sum key) (list max-suml max-keyl)))
                                                        (Max-sum (car Max-sum-and-key))
                                                        (Max-key (cadr Max-sum-and-key)))
                                                   (interior-info Sum
                                                                  Max-sum
                                                                  Max-key)))
                                      (interior-info (sumr max-sumr max-keyr)
                                                     (let* ((Sum (+ suml sumr))
                                                            (Max-sum-and-key-3 (max-sum-and-key-3 (list Sum key) (list max-suml max-keyl) (list max-sumr max-keyr)))
                                                            (Max-sum (car Max-sum-and-key-3))
                                                            (Max-key (cadr Max-sum-and-key-3)))
                                                       (interior-info Sum
                                                                      Max-sum
                                                                      Max-key)))))))))))

(define max-sum-and-key
  (lambda (L R)
    (if (> (car L) (car R))
        L
        R))) 
(define max-sum-and-key-3
  (lambda (L1 L2 L3)
    (max-sum-and-key L1
                     (max-sum-and-key (L2 L3)))))



(eopl:printf "~s"(eq? (max-interior tree-1) 'foo))  



