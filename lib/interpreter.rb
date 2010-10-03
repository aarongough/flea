class Environment < Hash
  def initialize( outer = nil )
    @outer = outer
    super
  end

  def find( key )
    if(self.has_key?(key))
      return self
    else
      return self if(@outer.nil?)
      return @outer.find(key)
    end
  end

  def add_globals
    self.merge!({
      :"+" => Proc.new do |args|
        args.inject {|sum, n| sum + n}
      end,
      
      :"-" => Proc.new do |args|
        args.inject {|sum, n| sum - n}
      end,
      
      :"*" => Proc.new do |args|
        args.inject {|sum, n| sum * n}
      end,
      
      :"/" => Proc.new do |args|
        args.inject {|sum, n| sum / n}
      end,
      
      :"==" => Proc.new do |args|
        result = args.map {|x| x == args[0]}
        !result.include?( false )
      end,
    })
  end
end

class Interpreter
  def run( ast )
    @global_environment = Environment.new
    @global_environment.add_globals
    ast.each do |x|
      evaluate(x, @global_environment)
    end
    return @global_environment
  end
  
  def evaluate( x, env )
    if x.is_a? Symbol
      return env.find(x)[x]
    elsif !x.is_a? Array
      return x
    else
      return execute_function(x, env)
    end
  end
  
  def execute_function(x, env)
    func = x.shift
    if func == :print
      print evaluate(x[0], env).inspect
    elsif func == :quote
      return x
    elsif func == :"set!"
      env.find(x[0])[x[0]] = evaluate(x[1], env)
    elsif func == :if
      return evaluate(x[1], env) if(evaluate(x[0], env))
    elsif func == :begin
      val = 0
      x.each do |i|
        val = evaluate(i, env)
      end
      return val
    elsif func == :lambda
      return Proc.new() do |args|
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
      return env.find(func)[func].call(x)
    end
  end
end