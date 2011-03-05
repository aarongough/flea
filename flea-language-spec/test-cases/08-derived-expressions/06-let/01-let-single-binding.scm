(define x 4)

(let ((x 2))
  (display (* x x)))
  
(display (* x x))

----

assert_output "416"