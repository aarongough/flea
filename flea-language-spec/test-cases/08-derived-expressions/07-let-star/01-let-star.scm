(let ((x 2) (y 3))
  (let* ((x 7)
         (z (+ x y)))
    (display (* z x))))
    
----

assert_output "70"