(define lambda (native_function "
  if(list[0].is_a?(Array))
    raise Exception, 'A variable name cannot be used more than once when defining a lambda argument list.' unless(list[0].uniq.length == list[0].length)
    Proc.new() do |args, env|
      sub_env = FleaEnvironment.new(env)
      vars = list[0]
      expression = list[1]
      vars.each_index do |i|
        sub_env[vars[i]] = args[i]
      end
      evaluate(expression, sub_env)
    end
  elsif(list[0].is_a?(Symbol))
    Proc.new() do |args, env|
      sub_env = FleaEnvironment.new(env)
      sub_env[list[0]] = args
      evaluate(list[1], sub_env)
    end
  else
  
  end
"))