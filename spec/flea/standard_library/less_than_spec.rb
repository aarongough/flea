# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'less-than?' do
    let(:interpreter) { Flea::Interpreter.new }

    it "return true if it's first argument is smaller than all the others" do
      result = interpreter.run('(less-than? 5 10 15 20)')
      expect(result).to be true
    end

    it "return false if it's first argument is not smaller than all the others" do
      result = interpreter.run('(less-than? 10 1 2 3 45)')
      expect(result).to be false
    end

    it 'should evaluate its arguments' do
      result = interpreter.run('
        (define a 2)
        (define b 10)
        (less-than? b a a)
      ')

      expect(result).to be false
    end
  end
end
