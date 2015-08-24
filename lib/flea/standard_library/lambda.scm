(define lambda
  (native_function "
    Proc.new() do |arguments, interpreter|
      formals = arguments[0]
      body = arguments.slice(1, arguments.length)

      if formals.is_a? Array
        # detect if any formal names have been used more than once
        error_message = 'Formal {FORMAL} declared more than once'
        formals.each_index do |x|
          tmp = formals.dup
          tmp.delete_at(x)

          raise(error_message.gsub('{FORMAL}', formals[x].to_s)) if tmp.include? formals[x]
        end
      end

      sub_env = Flea::Environment.new(interpreter.current_environment)

      execute_body = Proc.new() do |body, environment, interpreter|
        interpreter.current_environment = environment
        result = nil
        body.each do |expression|
          result = interpreter.evaluate(expression)
        end
        interpreter.current_environment = environment.parent
        result
      end

      if formals.is_a?(Array) && formals.include?(:'.')
        Proc.new() do |arguments, interpreter|
          args = arguments.dup
          named_formals = formals.slice(0, formals.index(:'.'))
          list_formal = formals[formals.index(:'.') + 1]
          named_formals.each_index do |i|
            sub_env.define(named_formals[i], interpreter.evaluate(args.shift))
          end
          sub_env.define(list_formal, args)
          execute_body.call(body, sub_env, interpreter)
        end

      elsif formals.is_a? Array
        Proc.new() do |arguments, interpreter|
          formals.each_index do |i|
            sub_env.define(formals[i], interpreter.evaluate(arguments[i]))
          end
          execute_body.call(body, sub_env, interpreter)
        end

      elsif formals.is_a? Symbol
        Proc.new() do |arguments, interpreter|
          arguments = arguments.map {|x| interpreter.evaluate(x) }
          sub_env.define(formals, arguments)
          execute_body.call(body, sub_env, interpreter)
        end
      end
    end
  "))
