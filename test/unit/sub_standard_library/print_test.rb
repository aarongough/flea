require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper.rb'))

class PrintTest < Test::Unit::TestCase

  test "should print integer literal" do
    old_stdout = $stdout
    buffer = StringIO.new
    $stdout = buffer
    env = Interpreter.new.run([[:print, 1]])
    assert_equal "1", buffer.string
    $stdout = old_stdout
  end
  
  test "should print list literal" do
    old_stdout = $stdout
    buffer = StringIO.new
    $stdout = buffer
    Interpreter.new.run([[:print, [:quote, 1, 2, 3]]])
    assert_equal "[1, 2, 3]", buffer.string
    $stdout = old_stdout
  end
  
end