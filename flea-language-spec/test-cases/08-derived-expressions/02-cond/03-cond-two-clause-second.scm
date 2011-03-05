(cond ((equal? #t #f) (display "first"))
      ((equal? #t #t) (display "second")))

----

assert_output "second"