(display 
  (case (* 2 2)
    ((1) 'one)
    ((2) 'two)
    ((3) 'three)
    ((4) 'four)
    ((5) 'five)))
    
----

assert_output "four"