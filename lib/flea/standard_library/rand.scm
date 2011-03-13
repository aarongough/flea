(define rand
  (native_function "
    Proc.new() do |arguments, interpreter|
      rand(interpreter.evaluate(arguments[0]))
    end
  "))