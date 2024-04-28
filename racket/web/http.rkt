#lang racket
(require http/request)
(define uri "www.baidu.com")
(define-values (scheme host port) (uri->scheme&host&port uri))
(call/requests
  scheme host port
  (lambda (in out)
    (define-values (path rh)
      (uri&headers->path&header uri '("Expect: 100-continue")))
    (define tx-data? (start-request in out "get" path rh "1.0"))
    (when tx-data?
      (display data out)
      (flush-output out)) ;Important!
    (define h (purify-port/log-debug in))
    (read-entity/bytes in h)))
