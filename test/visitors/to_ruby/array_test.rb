require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyArrayTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert empty array" do
      src = " [ ] "
      assert { to_ruby(src) == src }
    end

    should "convert array" do
      src = " [1, 2, 3] "
      assert { to_ruby(src) == src }
    end

    should "convert array with trailing comma" do
      src = " [1, 2, 3, ]  "
      assert { to_ruby(src) == src }
    end

    should "convert array with mixed elements" do
      src = " [ :foo, 'bar' , baz(), QUX]  "
      assert { to_ruby(src) == src }
    end
  end
end
