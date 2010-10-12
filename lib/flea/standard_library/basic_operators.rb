(define + 
  (native_function "
    tmp = list.map {|item| evaluate(item, env)}
    tmp.inject {|sum, n| sum + n}
  "))
  
(define -
  (native_function "
    tmp = list.map {|item| evaluate(item, env)}
    tmp.inject {|sum, n| sum - n}
  "))
  
(define * 
  (native_function "
    tmp = list.map {|item| evaluate(item, env)}
    tmp.inject {|sum, n| sum * n}
  "))
  
(define / 
  (native_function "
    tmp = list.map {|item| evaluate(item, env)}
    tmp.inject {|sum, n| sum / n}
  "))
  
(define = 
  (native_function "
    !(list.map{|x| evaluate(x, env) == evaluate(list[0], env)}).include?( false )
  "))
  
(define equal? 
  (native_function "
    !(list.map{|x| evaluate(x, env) == evaluate(list[0], env)}).include?( false )
  "))