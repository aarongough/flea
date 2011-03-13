(define string-to-num
  (native_function "
    Proc.new() do |arguments, interpreter|
      interpreter.evaluate(arguments[0]).to_i
    end
  "))