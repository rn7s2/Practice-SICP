#lang sicp

(define (miller-rabin-test n)
  (define (expmod base exp mod)
    (cond ((= exp 0) 1)
          ((even? exp)
           (let* ((v (expmod base (/ exp 2) mod))
                  (v-sqr-mod (modulo (square v) mod)))
             (if (and (not (= v 1))
                      (not (= v (- n 1)))
                      (= v-sqr-mod 1))
                 0
                 v-sqr-mod)))
          (else (modulo (* (expmod base (- exp 1) mod) base) mod))))
  (define (try-each cur)
    (define (try-it a)
      (cond ((= (expmod a n n) a) #t)
            (else (display a)
                  (display " faild test.")
                  (newline))))
    (cond ((>= cur n) #t)
          (else
           (try-it cur)
           (try-each (+ cur 1)))))
  (display "******************* begin test: ")
  (display n)
  (display " *******************")
  (newline)
  (try-each 1))

(map miller-rabin-test '(561 1105 1729 2465 2821 6601))
(map miller-rabin-test '(10 20 30 40))
