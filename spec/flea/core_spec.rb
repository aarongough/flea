require File.dirname(__FILE__) + '/../spec_helper'

describe "Flea" do
  describe "::Core"

  include Flea
  
  describe ".create_native_function" do
    it "should evaluate a ruby string" do
      Core.create_native_function("
        Proc.new() do |arguments, interpreter|
          # nothing
        end
      ").should be_a Proc
    end
  end
  
end