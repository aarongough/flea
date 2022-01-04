# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'begin' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'should execute each expression after the begin call and return final value' do
      result = interpreter.run('
        (begin
          (define test 1)
          (set! test 2))
      ')

      expect(result).to equal(2)
      expect(interpreter.base_environment.find(:test)).to eq(2)
    end
  end
end
