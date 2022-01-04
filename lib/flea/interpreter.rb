# frozen_string_literal: true

module Flea
  class Interpreter
    attr_accessor :base_environment,
                  :current_environment,
                  :parser

    def initialize(base_environment: Environment.new, standard_library: true)
      @base_environment = @current_environment = base_environment
      @parser = Sexpistol.new
      @parser.ruby_keyword_literals = false
      @parser.scheme_compatability = true

      load_standard_library if standard_library
    end

    def run(program)
      expressions = parse(program)
      result = nil
      expressions.each do |expression|
        result = evaluate(expression)
      end

      result
    end

    def evaluate(expression)
      return @current_environment.find(expression) if expression.is_a? Symbol
      return expression unless expression.is_a? Array

      case expression[0]
      when :define          then @current_environment.define expression[1], evaluate(expression[2])
      when :native_function then eval expression[1]
      else
        function = evaluate(expression[0])
        raise "\n#{@parser.to_sexp(expression)}\n ^\n\n#{expression[0]} is not a function" unless function.is_a? Proc

        arguments = expression.slice(1, expression.length)
        function.call(arguments, self)
      end
    end

    private

    def parse(string)
      @parser.parse_string(string)
    end

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
