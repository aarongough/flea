(define lambda (native_function "
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
"))