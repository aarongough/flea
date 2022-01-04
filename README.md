[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Actions Status](https://github.com/aarongough/flea/actions/workflows/build.yml/badge.svg)](https://github.com/aarongough/flea/actions/workflows/build.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/eae94ce7c694372a56cb/maintainability)](https://codeclimate.com/github/aarongough/flea/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/eae94ce7c694372a56cb/test_coverage)](https://codeclimate.com/github/aarongough/flea/test_coverage)
[![Gem Version](https://badge.fury.io/rb/flea.svg)](https://badge.fury.io/rb/flea)

# Flea

Flea is a tiny Lisp interpreter implemented in Ruby. Flea is not designed to be a production language, instead it is designed to be an example of how simple it can be to bootstrap the core of a small flexible language. Flea essentially defines an informal subset of Scheme, just enough to be fun and interesting.

### A Quick Example:

This is the classic 'guess the number' program implemented in Flea:

```scheme
(define number (+ (rand 9) 1))

(display "\n\nI'm thinking of a number between 1 and 10,\n")
(display "try to guess it!\n\n")

(define user-guess 
  (lambda () 
    (display "Take a guess - ")
    (define guess (string-to-num (gets)))
    (if (equal? guess number)
      (display "Good guess!\n")
      (begin
        (if (greater-than? guess number)
          (display "Lower!\n")
          (display "Higher!\n"))
        (user-guess)))))

(user-guess)
```

### Installation:

For ease of use the Flea is packaged as a RubyGem. Providing you already have Ruby and RubyGems installing Flea is as easy as entering the following command in a terminal:

    gem install flea
  
Mac OS X and most Unix/Linux distributions come with an installation of Ruby and RubyGems. If you do not have Ruby and RubyGems installed please check the [Ruby website for instructions](http://www.ruby-lang.org/en/downloads/).

### Usage:

After Flea is installed you can run a program by typing the following on the command line:

    flea /path/to/program
  
You can also launch Flea's interactive shell by simply calling `flea` with no arguments.

## How it works:

Flea's core is only about 100 lines of code, and provides a simple interface that is used to build the rest of the language. Flea is highly extensible because of its foreign function interface which allows Ruby Proc objects to be defined and then executed within the context of the Flea interpreter. The entire standard library of the language is implemented using this foreign function interface. For example, here is the implementation of the multiplication operator:

```scheme
(define * 
  (native_function "
    Proc.new() do |arguments, interpreter|
      tmp = arguments.map {|item| interpreter.evaluate(item)}
      tmp.inject {|sum, n| sum * n}
    end
  "))
```
    
## API Documentation:

Flea comes with a small but thoughtful standard library that includes functions for:

#### Output:

`(display)` Outputs data to STDOUT:

```scheme
(display "test")
# => test

(display '(1 2 3))
# => (1 2 3)
```

#### Input:

`(read)` Reads and parses an s-expression from STDIN:

```scheme
(read) # user enters '(1 2 3)'
# => (1 2 3)
```

`(gets)` Reads a string from STDIN:

```scheme
(gets) # user enters '(1 2 3)'
# => "(1 2 3)"
```

#### Variables:

`(define)` Sets a variable:

```scheme
(define test 1)
(display test)
# => 1
```

`(set!)` Re-defines an existing variable:

```scheme
(define test 1)
(set! test 2)
(display test)
# => 2  
```

#### Numeric operations:

`(+)` Add one or more numbers:

```scheme  
(+ 1 2 3)
# => 6
```

`(-)` Subtract one or more numbers:

```scheme
(- 10 2 1)
# => 7
```

`(*)` Multiply one or more numbers:

```scheme
(* 10 2 4)
# => 80
```

`(/)` Divide one or more numbers:

```scheme
(/ 100 2 2)
# => 25
```

`(greater-than?)` Returns true if it's first argument is greater than all the others, false otherwise:

```scheme
(greater-than? 10 2 3 4)
# => #t

(greater-than? 1 2 3 4)
# => #f
```

`(less-than?)` Returns true if it's first argument is smaller than all the others, false otherwise:

```scheme
(less-than? 1 3 4 5)
# => #t

(less-than? 50 2 45 100)
 # => #f
```

`(equal?)` and `(=)` Return true if all their arguments are the same, false otherwise:

```scheme
(equal? 1 1 1)
# => #t

(= 1 2 3)
# => #f
```

#### List creation and manipulation:

`(list)` Creates a new list from it's arguments:

```scheme
(list (+ 1 2) "test" (rand 10))
# => (3 "test" 5)
```

`(list?)` Returns true if it's first argument is a list, false otherwise:

```scheme
(list? '())
# => #t

(list? 1)
# => #f
```

`(list-tail)` Returns a new list created by removing the first n elements of the provided list:

```scheme
(define a '(1 2 3 4 5 6))
(list-tail a 3)
# => (4 5 6)
```

`(car)` Returns the first item of a list:

```scheme
(car '(1 2 3))
# => 1
```

`(cdr)` Returns the remainder of a list:

```scheme
(cdr '(1 2 3))
# => (2 3)
```

`(cons)` Creates a new list by using it's first argument as the CAR it's second argument as the CDR:

```scheme
(cons '(1 2 3) 3)
# => ((1 2 3) 3)

(cons 1 2)
# => (1 2)


(cons 1 (2 3 4))
# => (1 2 3 4)
```

`(append)` Creates a new list by concatenating it's arguments, it's first argument must be a list:

```scheme
(append '(1 2) '(3 4) 5)
# => (1 2 3 4 5)
```

`(null?)` Returns true if it's first argument is null (the empty list):

```scheme
(null '())
# => #t

(null '(1 2 3))
# => #f

(null? 1)
# => #f
```

#### Conditionals:

`(if)` If it's first argument is true then it will execute it's first code block, otherwise it will execute the second code block (if any):

```scheme
(if (equal? 1 1)
  (display "true")
  (display "false"))
# => true

(if (equal? 2 1)
  (display "true")
  (display "false"))
# => false
```

#### Function creation:

`(lambda)` Creates a new function:

```scheme
(define adder
  (lambda (a)
    (+ a 10)))
    
(adder 5)
# => 15
```

For more info on lambda syntax read the [R5RS Scheme specification](http://schemers.org/Documents/Standards/R5RS/HTML/r5rs-Z-H-7.html#%_sec_4.1.4).

### Type conversion:

`(string-to-num)` Converts a string containing a number into a numeric literal:

```scheme
(string-to-num "123")
# => 123
```

#### Misc:

`(rand)` Returns a random number less than or equal to it's first argument:

```scheme
(rand 10)
# => 1

(rand 10)
# => 6
```

#### Foreign function interface:

`(native_function)` Takes a string representing a Ruby Proc object and returns it in a form that is able to be called like any other Flea function. The proc must take two arguments (arguments and interpreter):

```scheme
(define test
  (native_function "
    Proc.new() do |arguments, interpreter|
      puts "Arguments class: " + arguments.class
      puts "Arguments: " + arguments.inspect
      puts "Interpreter class: " + interpreter.class
      puts "foo"
    end
  ")

(test 1 2 3 4)
# => Arguments class: Array
     Arguments: [1, 2, 3, 4]
     Interpreter class: Flea::Interpreter
     foo
```
   
## Development and Testing:

Before doing any development work make sure you have all the development dependencies installed by running `bundle install` in the root of the project directory.

Making changes to Flea is made simpler by the presence of an extensive test suite. Tests are written in [RSpec](https://rspec.info/) and live in the `/spec` folder. To run the tests simply type `rspec` in the root of the project directory.

Flea also has an 'executable language specification' which is a series of small programs that exercise every part of the language and also assert what the output for each small program should be. The language specification is written with the use of a helper tool called [AnySpec](https://github.com/aarongough/any-spec), and the test cases can be found at `/flea-language-spec`. To run the executable language specification run the following command from the root of the project directory:

```
any-spec ./bin/flea flea-language-spec/flea-language-spec.yaml
```

---

### Author & Credits:

Author: [Aaron Gough](mailto:aaron@aarongough.com)

Copyright © 2021 [Aaron Gough](http://thingsaaronmade.com/), released under the MIT license

