# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'rand' do
    let(:interpreter) { Flea::Interpreter.new }

    10.times do
      it 'should return a random number lower than or equal to 10' do
        result = interpreter.run('(rand 10)')
        expect(result).to be < 11
      end

      it 'should evaluate its arguments' do
        result = interpreter.run('
          (define a 10)
          (rand a)
        ')

        expect(result).to be < 11
      end
    end
  end
end
