(define lambda 
  (native_function "
    formals = arguments[0]
    body = arguments.slice(1, arguments.length)
    
    formals = [formals] if formals.is_a? Symbol
    
    # detect if any formal names have been used more than once
    error_message = 'Formal {FORMAL} declared more than once' 
    formals.each_index do |x| 
      tmp = formals.dup
      tmp.delete_at(x)
      raise(error_message.gsub('{FORMAL}', formals[x])) if tmp.include? formals[x] 
    end
    
    Proc.new() do |environment, arguments, interpreter|
      sub_env = Flea::Environment.new(interpreter.current_environment)
      formals.each_index do |i|
        sub_env.define(formals[i], arguments[i])
      end
      interpreter.current_environment = sub_env
      result = nil
      body.each do |expression|
        result = interpreter.evaluate(expression)
      end
      interpreter.current_environment = sub_env.parent
      result
    end
  "))