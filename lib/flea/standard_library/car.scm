(define car
  (native_function "
    Proc.new() do |argument, interpreter|
      list = interpreter.evaluate(argument[0])
      list[0]
    end
  "))