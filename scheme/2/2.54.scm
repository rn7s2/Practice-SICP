(define (equal? a b)
  (cond ((and (symbol? a) (symbol? b) (eq? a b)) #t)
        ((and (list? a) (list? b)
              (equal? (car a) (car b))
              (equal? (cdr a) (cdr b)))
         #t)
        (else #f)))