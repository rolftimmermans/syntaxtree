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

    should "convert array element method call" do
      src = " foo [1 ] "
      assert { to_ruby(src) == src }
    end

    should "convert array element method call with multiple arguments" do
      src = " foo [ 1, 'foo' ] "
      assert { to_ruby(src) == src }
    end

    should "convert method call with keyword identifier" do
      src = "foo.if(baz, qux)"
      assert { to_ruby(src) == src }
    end

    should "convert method call with operator" do
      src = "foo.<<(bar)"
      assert { to_ruby(src) == src }
    end

    should "convert method call without parentheses" do
      src = "foo.bar baz, qux"
      assert { to_ruby(src) == src }
    end

    should "convert method call with keyword identifier without parentheses" do
      src = "foo.class"
      assert { to_ruby(src) == src }
    end
  end
end
