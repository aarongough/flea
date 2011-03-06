(define quote 
  (native_function "
    Proc.new() do |arguments, interpreter|
      arguments[0]
    end
  "))
