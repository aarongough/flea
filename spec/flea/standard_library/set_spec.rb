# frozen_string_literal: true

require 'spec_helper'

describe 'Standard Library' do
  describe 'set!' do
    let(:interpreter) { Flea::Interpreter.new }

    it 'should change the value of an existing variable' do
      interpreter.run('
        (define test 1)
        (set! test 2)')

      expect(interpreter.base_environment.find(:test)).to eq(2)
    end

    it 'should raise error when attempting to set unbound variable' do
      expect do
        interpreter.run('(set! test 1)')
      end.to raise_error(TypeError)
    end
  end
end
