class Flea
  def self.run(string, includes = $standard_library)
    unless(defined? @@parser)
      @@parser = Sexpistol.new
      @@parser.ruby_keyword_literals = true
    end
    string = includes + string
    ast = @@parser.parse_string(string)
    self.run_without_parse(ast)
  end

  def self.run_without_parse(ast)
    @@instance = self.new unless(defined? @@instance)
    @@instance.execute(ast)
  end

  def execute(ast)
    environment = FleaEnvironment.new
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
    if func == :"set!" || func == :define
      env.find(x[0])[x[0]] = evaluate(x[1], env)
    elsif func == :native_function
      function = "Proc.new do |list, env|\n"
      function += x[0]
      function += "\nend"
      return eval function
    else
      raise Exception, "'#{func}' is not a function" unless(env.find(func)[func])
      return env.find(func)[func].call(x, env)
    end
  end
end