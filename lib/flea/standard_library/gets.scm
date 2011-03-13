(define gets
  (native_function "
    Proc.new() do |arguments, interpreter|
      $stdin.gets
    end
  "))