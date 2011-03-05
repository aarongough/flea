(display 
  (case (* 2 1)
    ((2 3 5 7) 'prime)
    ((1 4 6 8 9) 'composite)))
    
----

assert_output "prime"