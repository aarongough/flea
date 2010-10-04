$standard_library.concat([
  [:set!, :if, [:__native_function, "
    evaluate(list[1], env) if(evaluate(list[0], env))
  "]]
])