(define n_or_more 
  (lambda (x y . z)
    ((lambda ()
      (display x)
      (display y)
      (display z)))))
    
(n_or_more 1 2 3 4 5 6)

----

assert_output "12(3 4 5 6)"