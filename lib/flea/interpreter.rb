module Flea
  class Interpreter
   
   attr_accessor :base_environment, :current_environment
   
    def initialize(options = {})
      options = {
        :base_environment => Environment.new,
      }.merge(options)
      @base_environment = @current_environment = options[:base_environment]
      @parser = Sexpistol.new
      @parser.ruby_keyword_literals = false
      @parser.scheme_compatability = true
    end
    
    def run(program)
      expressions = parse(program)
      result = nil
      expressions.each do |expression|
        result = evaluate(expression)
      end
      return result
    end
    
    def parse(string)
      return @parser.parse_string(string)
    end
    
    def evaluate(expression)
      return @current_environment.find(expression) if expression.is_a? Symbol
      return expression unless expression.is_a? Array
      if expression[0] == :define
        return @current_environment.define expression[1], evaluate(expression[2])
      elsif expression[0] == :native_function
        return Core.create_native_function expression[1]
      else # function call
        function = evaluate(expression[0])
        raise RuntimeError, "#{@parser.to_sexp(expression)}\n ^\n\n#{expression[0]} is not a function" unless function.is_a? Proc
        arguments = expression.slice(1, expression.length)
        function.call(@current_environment, arguments)
      end
    end
    
  end
end