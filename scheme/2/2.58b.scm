#lang racket

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp) (make-sum (make-product (multiplier exp)
                                                (deriv (multiplicand exp) var))
                                  (make-product (deriv (multiplier exp) var)
                                                (multiplicand exp))))
        (else (error "unknown expression type -- DERIV" exp))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (normalize x)
  (cond ((or (number? x)
             (variable? x)) x)
        ((< (length x) 5) (list (normalize (car x)) (cadr x) (normalize (caddr x))))
        ((list? x)
         (if (and (eq? (cadr x) '+)
                  (eq? (cadddr x) '*))
             (append (list (normalize (car x))
                           '+
                           (list (normalize (caddr x))
                                 '*
                                 (normalize (car (cddddr x)))))
                     (cdr (cddddr x)))
             (append (list (list (normalize (car x))
                                 (cadr x)
                                 (normalize (caddr x)))
                           (cadddr x)
                           (normalize (car (cddddr x))))
                     (cdr (cddddr x)))))))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (cons (normalize a1) (cons '+ (cons (normalize a2) '()))))))
(define (sum? x)
  (and (pair? x)
       (eq? (cadr x) '+)
       (not (null? (cddr x)))))
(define addend car)
(define augend caddr)

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (cons (normalize m1) (cons '* (cons (normalize m2) '()))))))
(define (product? x)
  (and (pair? x)
       (eq? (cadr x) '*)
       (not (null? (cddr x)))))
(define multiplier car)
(define multiplicand caddr)

(define (deriv-1 exp x)
  (deriv (normalize exp) x))

(deriv-1 '(x + 3 * (x * x + x + y + 2)) 'x)
