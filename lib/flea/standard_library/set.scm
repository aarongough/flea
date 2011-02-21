(define set!
  (native_function "
    interpreter.current_environment.define(arguments[0], arguments[1])
  "))