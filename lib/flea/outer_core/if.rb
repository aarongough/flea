(define if (native_function "
  first_consequent = list[0]
  if(evaluate(list[0], env))
    evaluate(list[1], env)
  else
    evaluate(list[2], env) unless(list[2].nil?)
  end
"))