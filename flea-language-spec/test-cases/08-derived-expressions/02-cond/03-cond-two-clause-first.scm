(cond ((equal? #t #t) (display "first"))
      ((equal? #t #t) (display "second")))

----

assert_output "first"