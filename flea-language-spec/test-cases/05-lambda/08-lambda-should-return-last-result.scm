(define a 0)
(define b 0)
(define test 
  (lambda (x y) 
    (+ 5 x)
    (+ 10 y)
    (+ x y)))
    
(define c (test 1 2))
(display a)
(display b)
(display c)

----

assert_output "003"