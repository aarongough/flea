(define display 
  (native_function "
    print Sexpistol.new.to_sexp(interpreter.evaluate(arguments[0]))
  "))