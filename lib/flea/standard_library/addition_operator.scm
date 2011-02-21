(define + 
  (native_function "
    tmp = arguments.map {|item| interpreter.evaluate(item)}
    tmp.inject {|sum, n| sum + n}
  "))