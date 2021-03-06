#lang sicp

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cond ((< (* n d) 0) (if (< n 0)
                             (cons (/ n g) (/ d g))
                             (cons (- (/ n g)) (- (/ d g)))))
          ((< n 0) (cons (- (/ n g)) (- (/ d g))))
          (else (cons (/ n g) (/ d g))))))
