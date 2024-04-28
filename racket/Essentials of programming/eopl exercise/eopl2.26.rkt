#lang eopl
;Red-blue-tree ::= Red-blue-subtree
;Red-blue-subtree ::= (red-node Red-blue-subtree Red-blue-subtree)
;                 ::= (blue-node {Red-blue-subtree}∗)
;                 ::= (leaf-node Int)
(define-datatype Red-blue-tree Red-blue-tree?
  (red-node (subtreel Red-blue-tree?)
            (subtreer Red-blue-tree?))
  (blue-node (sons (list-of Red-blue-tree?)))
  (leaf-node (num integer?)))
(define-datatype tree-info tree-info?
  (leaf-info (num integer?))
  (interior-info (num integer?)))
(define make-leaves-with-red-depth
  (lambda (tree)
    (make-leaves-with-red-depth-helper tree 0)))
(define make-leaves-with-red-depth-helper
  (lambda (tree red-num)
    (cases Red-blue-tree tree
      (red-node (subl subr)
                (red-node (make-leaves-with-red-depth-helper subl (+ red-num 1))
                          (make-leaves-with-red-depth-helper subr (+ red-num 1))))
      (blue-node (sons)
                 (blue-node (map (lambda (son)
                                   (make-leaves-with-red-depth-helper son red-num))
                                 sons)))
      (leaf-node (num)
                 (leaf-node red-num)))))





