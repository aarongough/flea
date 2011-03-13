(define cdr
  (native_function "
    Proc.new() do |argument, interpreter|
      list = interpreter.evaluate(argument[0])
      list.slice(1, list.length)
    end
  "))