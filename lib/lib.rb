self.merge!({
  :"+" => Proc.new do |args|
    args.inject {|sum, n| sum + n}
  end,
  
  :"-" => Proc.new do |args|
    args.inject {|sum, n| sum - n}
  end,
  
  :"*" => Proc.new do |args|
    args.inject {|sum, n| sum * n}
  end,
  
  :"/" => Proc.new do |args|
    args.inject {|sum, n| sum / n}
  end,
  
  :"==" => Proc.new do |args|
    result = args.map {|x| x == args[0]}
    result.include?( false )
  end,
})