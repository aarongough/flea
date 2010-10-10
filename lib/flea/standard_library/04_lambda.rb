$standard_library.concat([
  [:define, :lambda, [:__native_function, "
    Proc.new() do |args, env|
      sub_env = FleaEnvironment.new(env)
      vars = list[0]
      expression = list[1]
      vars.each_index do |i|
        sub_env[vars[i]] = args[i]
      end
      evaluate(expression, sub_env)
    end
  "]]
])