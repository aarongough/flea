(define countdown
  (lambda (index)
    (define current (- index 1))
    (display current)
    (if (equal? current 0)
      (display "... Blast off!")
      (begin 
        (display ", ")
        (countdown current)))))
        
(countdown 11)

----

assert_output "10, 9, 8, 7, 6, 5, 4, 3, 2, 1... Blast off!"