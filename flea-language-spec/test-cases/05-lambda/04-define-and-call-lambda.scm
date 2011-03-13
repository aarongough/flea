(define test_add
  (lambda (x y) (+ x y)))
  
(display (test_add 5 10))

----

assert_output "15"