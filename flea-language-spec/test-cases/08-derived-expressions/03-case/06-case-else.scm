(display 
  (case (* 2 5)
    ((1) 'one)
    ((2) 'two)
    ((3) 'three)
    ((4) 'four)
    ((5) 'five)
    (else "not found")))
    
----

assert_output "not found"