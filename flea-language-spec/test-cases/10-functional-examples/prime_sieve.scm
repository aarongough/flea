(define init
  (lambda (limit current list)
    (if (equal? limit current)
      list
      (init limit (+ current 1) (append list ((current)))))))

(display (init 10 0 (quote ())))

----

assert_output "23"

