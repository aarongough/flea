(define less-than? 
  (native_function "
    Proc.new() do |arguments, interpreter|
      arguments.slice(1, arguments.length).all? do |x|
        interpreter.evaluate(arguments[0]) < interpreter.evaluate(x)
      end
    end
  "))