(define list-1 (quote (1 2 3)))
(define list-2 (quote (4 5 6)))
(define list-3 (quote (7 8 9)))

(display (append list-1 list-2))
(display (append list-1 list-2 list-3))

----

assert_output "(1 2 3 4 5 6)(1 2 3 4 5 6 7 8 9)"