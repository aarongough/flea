(define display 
  (native_function "
    output = interpreter.evaluate(arguments[0])
    print interpreter.parser.to_sexp(output)
    output
  "))