(define read
  (native_function "
    Proc.new() do |arguments, interpreter|
      interpreter.parse($stdin.gets)
    end
  "))