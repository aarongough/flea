(define display 
  (native_function "
    Proc.new() do |arguments, interpreter|
      output = interpreter.evaluate(arguments[0])

      if output.is_a?(String)
        print output
      else
        print interpreter.to_sexp(output)
      end

      output
    end
  "))