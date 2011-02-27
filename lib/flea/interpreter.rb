module Flea
  class Interpreter
   
   attr_accessor :base_environment, :current_environment
   
    def initialize(options = {})
      options = {
        :base_environment => Environment.new,
        :load_standard_library => true
      }.merge(options)
      @base_environment = @current_environment = options[:base_environment]
      @parser = Sexpistol.new
      @parser.ruby_keyword_literals = false
      @parser.scheme_compatability = true
      load_standard_library unless options[:load_standard_library] == false
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
        return function.call(@current_environment, arguments, self)
      end
    end
    
    private 
    
    def load_standard_library
      library_pattern = File.join(File.dirname(__FILE__), 'standard_library', '*.scm')
      Dir[library_pattern].each do |item|
        File.open(item) do |file|
          run(file.read)
        end
      end
    end
    
  end
end