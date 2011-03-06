(define = 
  (native_function "
    Proc.new() do |arguments, interpreter|
      !(arguments.map{|x| interpreter.evaluate(x) == interpreter.evaluate(arguments[0])}).include?( false )
    end
  "))
  
(define equal? =)