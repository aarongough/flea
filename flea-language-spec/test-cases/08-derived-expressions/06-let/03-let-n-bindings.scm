(define x 4)
(define y 10)
(define z 2)
(define a 3)

(let ((x 2) (y 3) (z 10) (a 20))
  (display (* x y))
  (display (* z a)))
  
(display (* x y))
(display (* z a))

----

assert_output "6200406"