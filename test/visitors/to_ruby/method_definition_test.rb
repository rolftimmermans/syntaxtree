require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyMethodDefinitionTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert method definition" do
      src = "def foo\n\n  puts 'foo'\nend"
      assert { to_ruby(src) == src }
    end

    should "convert method definition with empty params" do
      src = "def foo() \n\n  puts 'foo'\nend"
      assert { to_ruby(src) == src }
    end

    should "convert method definition with params" do
      src = "def foo(bar, baz = 2, qux = {}, *rest, &block)\n\n  puts 'foo'\nend"
      assert { to_ruby(src) == src }
    end

    should "convert method definition on constant" do
      src = "def Foo::bar(baz, qux = nil)\n\n  puts 'foo'\nend"
      assert { to_ruby(src) == src }
    end

    should "convert method definition on self" do
      src = "def self.foo(bar, baz = nil)\n\n  puts 'foo'\nend"
      assert { to_ruby(src) == src }
    end

    should "convert method definition on identifier" do
      src = "def foo.bar(baz, qux, quux = nil)\n\n  puts 'foo'\nend"
      assert { to_ruby(src) == src }
    end
  end
end
