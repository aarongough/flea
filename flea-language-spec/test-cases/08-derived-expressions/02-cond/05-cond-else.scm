(cond ((equal? #t #f) (display "first"))
      ((equal? #t #f) (display "second"))
      ((equal? #t #f) (display "third"))
      ((equal? #t #f) (display "fourth"))
      ((equal? #t #f) (display "fifth"))
      ((equal? #t #f) (display "sixth"))
      (else (display "else")))

----

assert_output "else"