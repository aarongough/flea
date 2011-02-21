(define = 
  (native_function "
    !(arguments.map{|x| interpreter.evaluate(x) == interpreter.evaluate(arguments[0])}).include?( false )
  "))