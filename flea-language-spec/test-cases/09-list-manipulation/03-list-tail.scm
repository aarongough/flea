(define test-list (quote (1 2 3 4 5 6)))

(display (list-tail test-list 3))

----

assert_output "(4 5 6)"