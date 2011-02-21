(define begin 
  (native_function "
    val = nil
    arguments.each do |i|
      val = interpreter.evaluate(i)
    end
    
    val
  "))