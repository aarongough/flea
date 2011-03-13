(define tester 1)
(display tester)
(set! tester 5)
(display tester)

----

assert_output "15"