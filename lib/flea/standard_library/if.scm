(define if 
  (native_function "
    Proc.new() do |arguments, interpreter|
      if(interpreter.evaluate(arguments[0]))
        interpreter.evaluate(arguments[1])
      else
        interpreter.evaluate(arguments[2]) unless(arguments[2].nil?)
      end
    end
  "))