(cond ((equal? #t #f) (display "first"))
      ((equal? #t #f) (display "second"))
      ((equal? #t #f) (display "third"))
      ((equal? #t #t) (display "fourth"))
      ((equal? #t #f) (display "fifth"))
      ((equal? #t #t) (display "sixth")))

----

assert_output "fourth"