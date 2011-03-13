(define / 
  (native_function "
    Proc.new() do |arguments, interpreter|
      tmp = arguments.map {|item| interpreter.evaluate(item)}
      tmp.inject {|sum, n| sum / n}
    end
  "))