(define require 
  (native_function "
    Proc.new do |arguments, interpreter|
      arguments[0][1].each {|x| require x} unless arguments.empty? && arguments[0][1].nil?
    end 
  "))