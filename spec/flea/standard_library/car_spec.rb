# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'car' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'should return first item of list' do
      result = interpreter.run('
        (car (quote (10 2 2)))
      ')

      expect(result).to eq(10)
    end
  end
end
