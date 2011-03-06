(define list-tail
  (lambda (x k)
    (if (equal? k 0)
        x
        (list-tail (cdr x) (- k 1)))))