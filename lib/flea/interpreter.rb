# frozen_string_literal: true

module Flea
  class Interpreter
    attr_accessor :base_environment, :current_environment

    def initialize(environment: Environment.new, standard_library: true)
      @base_environment = @current_environment = environment

      load_standard_library if standard_library
    end

    def run(program)
      program = parse(program)
      result = nil
      


      if program.is_a?(Sexpistol::SExpressionArray)
        program.each do |expression|
          result = evaluate(expression)
        end
        
      else
        result = evaluate(program)
      end

      result
    end

    def evaluate(expression)
      return @current_environment.find(expression) if expression.is_a? Symbol
      return expression unless expression.is_a? Array

      case expression[0]
      when :define then @current_environment.define(expression[1], evaluate(expression[2]))
      when :native_function then eval expression[1]
      else
        function = evaluate(expression[0])
        raise "\n#{to_sexp(expression)}\n ^\n\n#{expression[0]} is not a function\n\n#{@current_environment.table.keys}" unless function.is_a? Proc

        arguments = expression.slice(1, expression.length)
        function.call(arguments, self)
      end
    end

    def parse(string)
      Sexpistol.parse(string, parse_ruby_keyword_literals: true)
    end

    def to_sexp(expression)
      Sexpistol.to_sexp(expression, scheme_compatability: true)
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
