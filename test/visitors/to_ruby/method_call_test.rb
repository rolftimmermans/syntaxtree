require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyMethodCallTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert method call with arguments" do
      src = "foo_bar(a, 3, :foo)"
      assert { to_ruby(src) == src }
    end

    should "convert method call with hash arguments" do
      src = "foo_bar!(a, 3, :foo => 3, :bar => 'bar', 4 => nil)"
      assert { to_ruby(src) == src }
    end

    should "convert method call with receivers" do
      src = "foo.bar(a, 3)"
      assert { to_ruby(src) == src }
    end

    should "convert method call with const receivers" do
      src = "FooClass.bar(a, 3)"
      assert { to_ruby(src) == src }
    end

    should "convert method call with const receivers with double colon operator" do
      src = "FooClass::bar(a, 3)"
      assert { to_ruby(src) == src }
    end

    should "convert method call with empty block" do
      src = "foo.bar(a, 3) { } "
      assert { to_ruby(src) == src }
    end

    should "convert method call with block with empty parameter list" do
      src = "foo.bar(a, 3) { ||  puts 'foo' } "
      assert { to_ruby(src) == src }
    end

    should "convert method call with block with parameters" do
      src = "foo.bar(a, 3) { | x , y | puts x } "
      assert { to_ruby(src) == src }
    end

    should "convert method call with block with excessed comma" do
      src = "foo.bar(a, 3) { | x, y, | puts x } "
      assert { to_ruby(src) == src }
    end

    should "convert method call with block with regular parameters after optional arguments" do
      src = "foo.bar(a, 3) { |x, y = 3, z|  puts x; } "
      assert { to_ruby(src) == src }
    end

    should "convert method call with block with all kinds of parameters" do
      src = "foo.bar(a, 3) { |x, y = 3, z = 'foo', *parameters, &block| puts x; puts y\n puts z } "
      assert { to_ruby(src) == src }
    end

    should "convert array element method call" do
      src = " foo [1 ] "
      assert { to_ruby(src) == src }
    end

    should "convert array element method call with multiple arguments" do
      src = " foo [ 1, 'foo' ] "
      assert { to_ruby(src) == src }
    end
  end
end
