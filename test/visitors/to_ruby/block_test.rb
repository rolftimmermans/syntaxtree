require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyBlockTest < Test::Unit::TestCase
  context "to ruby" do
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

    should "convert method call with do block with empty parameter list" do
      src = "foo.bar(a, 3) do ||\n  puts 'foo'\nend "
      assert { to_ruby(src) == src }
    end

    should "convert method call with do block with parameters" do
      src = "foo.bar(a, 3) do | x , y | \n  puts x \nend "
      assert { to_ruby(src) == src }
    end

    should "convert method call with do block with regular parameters after optional arguments" do
      src = "foo.bar(a, 3) do |x, y = 3, z|\n  puts x; \nend "
      assert { to_ruby(src) == src }
    end

    should "convert method call with do block with all kinds of parameters" do
      src = "foo.bar(a, 3) do |x, y = 3, z = 'foo', *parameters, &block|\n  puts x; puts y\n  puts z\nend "
      assert { to_ruby(src) == src }
    end
    
    should "convert lambda" do
      src = "lambda { |foo, bar = nil, *args| puts 'foo' }"
      assert { to_ruby(src) == src }
    end
  end
end
