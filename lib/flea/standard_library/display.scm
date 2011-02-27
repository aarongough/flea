(define display 
  (native_function "
    output = interpreter.evaluate(arguments[0])
    print Sexpistol.new.to_sexp(output)
    output
  "))