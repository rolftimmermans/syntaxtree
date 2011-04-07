require File.expand_path("../test_helper", File.dirname(__FILE__))

class MethodCallTest < Test::Unit::TestCase
  context "method call with empty args" do
    subject { statement("foo()") }

    should "be method call" do
      assert { subject.kind_of? Ruby::MethodCall }
    end

    should "have no receiver" do
      assert { subject.receiver == nil }
    end

    should "have no operator" do
      assert { subject.operator == nil }
    end

    should "have argument list" do
      assert { subject.arguments.kind_of? Ruby::ArgumentList }
    end

    should "have argument list with left delimiter" do
      assert { subject.arguments.left_delim.token == "(" }
    end

    should "have argument list with right delimiter" do
      assert { subject.arguments.right_delim.token == ")" }
    end

    should "include delimiters in nodes" do
      assert { subject.arguments.nodes.first.kind_of? Ruby::Token }
    end
  end

  context "method call with primitive args" do
    subject { statement("foo(1, 2)") }

    should "be method call" do
      assert { subject.kind_of? Ruby::MethodCall }
    end

    should "have argument list" do
      assert { subject.arguments.kind_of? Ruby::ArgumentList }
    end

    should "have argument list with left delimiter" do
      assert { subject.arguments.left_delim.token == "(" }
    end

    should "have argument list with right delimiter" do
      assert { subject.arguments.right_delim.token == ")" }
    end

    should "have primitive argument" do
      assert { subject.arguments.first.kind_of? Ruby::Integer }
    end

    should "have primitive argument with token" do
      assert { subject.arguments.first.token == "1" }
    end

    should "have primitive argument with prologue" do
      assert { subject.arguments.last.prologue.to_s == ", " }
    end
  end

  context "method call with hash argument" do
    subject { statement("foo(1, :foo => :bar)") }

    should "be method call" do
      assert { subject.kind_of? Ruby::MethodCall }
    end

    should "have argument list" do
      assert { subject.arguments.kind_of? Ruby::ArgumentList }
    end

    should "have argument list with hash" do
      assert { subject.arguments.last.kind_of? Ruby::Hash }
    end

    should "have argument list with hash assoc" do
      assert { subject.arguments.last.first.kind_of? Ruby::Association }
    end

    should "have argument list with hash with assoc key" do
      assert { subject.arguments.last.first.key.identifier.token == "foo" }
    end

    should "have argument list with hash with assoc value" do
      assert { subject.arguments.last.first.value.identifier.token == "bar" }
    end

    should "have argument list with hash with assoc operator" do
      assert { subject.arguments.last.first.operator.token == "=>" }
    end
  end

  context "method call with splat argument" do
    subject { statement("foo(1, *args)") }

    should "be method call" do
      assert { subject.kind_of? Ruby::MethodCall }
    end

    should "have argument list" do
      assert { subject.arguments.kind_of? Ruby::ArgumentList }
    end

    should "have argument list with splat argument" do
      assert { subject.arguments.last.kind_of? Ruby::SplatArgument }
    end

    should "have argument list with splat argument identifier" do
      assert { subject.arguments.last.identifier.token == "args" }
    end

    should "have argument list with splat argument with left delim" do
      assert { subject.arguments.last.left_delim.token == "*" }
    end
  end

  context "method call with block argument" do
    subject { statement("foo(1, &block)") }

    should "be method call" do
      assert { subject.kind_of? Ruby::MethodCall }
    end

    should "have argument list" do
      assert { subject.arguments.kind_of? Ruby::ArgumentList }
    end

    should "have argument list with block argument" do
      assert { subject.arguments.last.kind_of? Ruby::BlockArgument }
    end

    should "have argument list with block argument with identifier" do
      assert { subject.arguments.last.identifier.token == "block" }
    end

    should "have argument list with block argument with left delim" do
      assert { subject.arguments.last.left_delim.token == "&" }
    end
  end

  context "method call with receiver" do
    subject { statement("foo.bar(1, 2)") }

    should "be method call" do
      assert { subject.kind_of? Ruby::MethodCall }
    end

    should "have receiver" do
      assert { subject.receiver.kind_of? Ruby::Identifier }
    end

    should "have receiver with token" do
      assert { subject.receiver.token == "foo" }
    end

    should "have operator" do
      assert { subject.operator.kind_of? Ruby::Token }
    end

    should "have operator with token" do
      assert { subject.operator.token == "." }
    end
  end

  context "method call with constant receiver" do
    subject { statement("FooBar.bar(1, 2)") }

    should "have method call" do
      assert { subject.kind_of? Ruby::MethodCall }
    end

    should "have constant receiver" do
      assert { subject.receiver.kind_of? Ruby::Constant }
    end

    should "have constant receiver with token" do
      assert { subject.receiver.token == "FooBar" }
    end

    context "with colon operator" do
      subject { statement("FooBar::bar(1, 2)") }

      should "should have operator" do
        assert { subject.operator.token == "::" }
      end
    end
  end

  context "method call without parens" do
    subject { statement("foo 1, 2") }

    should "be method call" do
      assert { subject.kind_of? Ruby::MethodCall }
    end

    should "have no receiver" do
      assert { subject.receiver == nil }
    end

    should "have no operator" do
      assert { subject.operator == nil }
    end

    should "have argument list" do
      assert { subject.arguments.kind_of? Ruby::ArgumentList }
    end

    should "have argument list without left delimiter" do
      assert { subject.arguments.left_delim == nil }
    end

    should "have argument list without right delimiter" do
      assert { subject.arguments.right_delim == nil }
    end
  end
end
