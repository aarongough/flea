class Environment < Hash
  def initialize( outer = nil )
    @outer = outer
  end

  def find(key)
    return self if(self.has_key?(key) || @outer.nil?)
    return @outer.find(key)
  end
end

class Interpreter
  def run(ast)
    environment = Environment.new
    ast = $standard_library + ast
    ast.each {|x| evaluate(x, environment)}
    return environment
  end
  
  def evaluate(x, env)
    return env.find(x)[x] if(x.is_a? Symbol)
    return x unless(x.is_a? Array)
    return execute_function(x, env)
  end
  
  def execute_function(x, env)
    x = x.dup
    func = x.shift
    if func == :"set!"
      env.find(x[0])[x[0]] = evaluate(x[1], env)
    elsif func == :if
      return evaluate(x[1], env) if(evaluate(x[0], env))
    elsif func == :begin
      val = 0
      x.each do |i|
        val = evaluate(i, env)
      end
      return val
    elsif func == :__native_function
      function = "Proc.new do |list, env|\n"
      function += x[0]
      function += "\nend"
      return eval function
    elsif func == :lambda
      return Proc.new() do |args, env|
        sub_env = Environment.new(env)
        vars = x[0]
        expression = x[1]
        vars.each_index do |i|
          sub_env[vars[i]] = args[i]
        end
        evaluate(expression, sub_env)
      end
    else
      raise Exception, "'#{func}' is not a function" unless(env.find(func)[func])
      return env.find(func)[func].call(x, env)
    end
  end
end