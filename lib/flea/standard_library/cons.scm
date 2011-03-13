(define cons
  (native_function "
    Proc.new() do |arguments, interpreter|
      arg_1 = interpreter.evaluate(arguments[0])
      arg_2 = interpreter.evaluate(arguments[1]).dup
      
      if arg_2.is_a? Array
        arg_2.unshift arg_1
      else
        [arg_1, arg_2]
      end
    end
  "))