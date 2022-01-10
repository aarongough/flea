# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'null?' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'should return true for an empty list' do
      result = interpreter.run('
        (null? (quote ()))
      ')

      expect(result).to be true
    end

    ['1', '"abc"', '(1 2 3)'].each do |value|
      it "should return false for #{value}" do
        result = interpreter.run("
          (null? (quote #{value}))
        ")

        expect(result).to be false
      end
    end
  end
end
