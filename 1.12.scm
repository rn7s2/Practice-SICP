#lang sicp

(define (comb n k)
  (cond ((= k 0) 1)
        ((= n k) 1)
        (else (+ (comb (- n 1) k)
                 (comb (- n 1) (- k 1))))))
(comb 5 3)
