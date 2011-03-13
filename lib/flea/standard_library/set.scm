(define set!
  (native_function "
    Proc.new() do |arguments, interpreter|
      if( interpreter.current_environment.find(arguments[0]) == nil)
        raise 'Cannot set unbound variable ' + arguments[0]
      end
      interpreter.current_environment.define(arguments[0], arguments[1])
    end
  "))