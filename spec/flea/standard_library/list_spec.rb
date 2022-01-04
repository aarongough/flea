# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'list' do
    let(:interpreter) { Flea::Interpreter.new }

    it "should create a list from it's arguments" do
      result = interpreter.run('(list 9 2 2)')
      expect(result).to eq([9, 2, 2])
    end

    it 'should evaluate its arguments before creating the list' do
      result = interpreter.run('
        (define a 2)
        (define b 9)
        (list b a a)
      ')

      expect(result).to eq([9, 2, 2])
    end
  end
end
