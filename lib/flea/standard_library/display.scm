(define display 
  (native_function "
    output = Sexpistol.new.to_sexp(interpreter.evaluate(arguments[0]))
    print output
    output
  "))