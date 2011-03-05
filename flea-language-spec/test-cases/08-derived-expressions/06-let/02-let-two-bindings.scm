(define x 4)
(define y 10)

(let ((x 2) (y 3))
  (display (* x y)))
  
(display (* x y))

----

assert_output "640"