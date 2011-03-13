(define read
  (native_function "
    Proc.new() do |arguments, interpreter|
      interpreter.parser.parse_string($stdin.gets)
    end
  "))
  
(define gets
  (native_function "
    Proc.new() do |arguments, interpreter|
      $stdin.gets
    end
  "))
  
(define string-to-int
  (native_function "
    Proc.new() do |arguments, interpreter|
      interpreter.evaluate(arguments[0]).to_i
    end
  "))
  
(define rand
  (native_function "
    Proc.new() do |arguments, interpreter|
      rand(interpreter.evaluate(arguments[0]))
    end
  "))
  
(define gt? 
  (native_function "
    Proc.new() do |arguments, interpreter|
      arguments.slice(1, arguments.length).all? do |x|
        interpreter.evaluate(arguments[0]) > interpreter.evaluate(x)
      end
    end
  "))
  
(define number (+ (rand 9) 1))
  
(display "\n\nI'm thinking of a number between 1 and 10,\n")
(display "try to guess it!\n\n")

(define user-guess 
  (lambda () 
    (display "Take a guess - ")
    (define guess (string-to-int (gets)))
    (if (equal? guess number)
      (display "Good guess!\n")
      (begin
        (if (gt? guess number)
          (display "Lower!\n")
          (display "Higher!\n"))
        (user-guess)))))
        
(user-guess)