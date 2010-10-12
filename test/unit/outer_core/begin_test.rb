require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper.rb'))

class BeginTest < Test::Unit::TestCase
  
  test "should execute each expression after the begin call and return final value" do
    env = Flea.run('
      (begin
        (define test 1)
        (set! test 2))
    ')
    assert_equal(2, env[:test])
  end
  
end