(define lambda (native_function "
  list = list.dup
  formals = list.shift
  body = list
  
  raise Exception, 'A variable name cannot be used more than once when defining a lambda argument list.' if(formals.is_a?(Array) && formals.uniq.length != formals.length)
  
  if(formals.is_a?(Array))
    if(formals.include?(:'.'))
      Proc.new() do |args, env|
        args = args.dup
        sub_env = FleaEnvironment.new(env)
        named_formals = formals.slice(0, formals.index(:'.'))
        list_formal = formals[formals.index(:'.') + 1]
        named_formals.each_index do |i|
          sub_env[named_formals[i]] = args.shift
        end
        sub_env[list_formal] = args
        result = nil
        body.each do |expression|
          result = evaluate(expression, sub_env)
        end
        result
      end
    else
      Proc.new() do |args, env|
        sub_env = FleaEnvironment.new(env)
        formals.each_index do |i|
          sub_env[formals[i]] = args[i]
        end
        result = nil
        body.each do |expression|
          result = evaluate(expression, sub_env)
        end
        result
      end
    end
  elsif(formals.is_a?(Symbol))
    Proc.new() do |args, env|
      sub_env = FleaEnvironment.new(env)
      sub_env[formals] = args
      result = nil
      body.each do |expression|
        result = evaluate(expression, sub_env)
      end
      result
    end
  end
"))