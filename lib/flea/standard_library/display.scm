(define display 
  (native_function "
    Proc.new() do |arguments, interpreter|
      output = interpreter.evaluate(arguments[0])
      print interpreter.parser.to_sexp(output)
      output
    end
  "))