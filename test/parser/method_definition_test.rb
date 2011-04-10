require File.expand_path("../test_helper", File.dirname(__FILE__))

class MethodDefinitionTest < Test::Unit::TestCase
  context "method def without params" do
    subject { statement "def foo\nend" }

    should "be method definition" do
      assert { subject.class == Ruby::MethodDefinition }
    end

    should "have identifier" do
      assert { subject.identifier.class == Ruby::Identifier }
    end

    should "have identifier with token" do
      assert { subject.identifier.token == "foo" }
    end

    should "have param list" do
      assert { subject.parameters.class == Ruby::ParameterList }
    end

    should "have empty param list" do
      assert { subject.parameters.size == 0 }
    end

    should "have param list without delims" do
      assert { subject.parameters.left_delim == nil }
    end

    should_have_delimiters "def", "end"
  end

  context "method def with empty params" do
    subject { statement "def foo()\nend" }

    should "be method definition" do
      assert { subject.class == Ruby::MethodDefinition }
    end

    should "have identifier" do
      assert { subject.identifier.token == "foo" }
    end

    should "have param list" do
      assert { subject.parameters.class == Ruby::ParameterList }
    end

    should "have empty param list" do
      assert { subject.parameters.size == 0 }
    end

    should "have param list with left delim" do
      assert { subject.parameters.left_delim.token == "(" }
    end

    should "have param list with right delim" do
      assert { subject.parameters.right_delim.token == ")" }
    end
  end

  context "method def with statements" do
    subject { statement "def foo(a, b)\n  puts 'foo'; puts b\n end" }

    should "have statements" do
      assert { subject.statements.class == Ruby::ExpressionList }
    end

    should "have statements with size" do
      assert { subject.statements.size == 2 }
    end
  end

  context "method def on constant" do
    subject { statement " def Foo::bar(a, b)\n  puts 'bar'\nend" }

    should "be method definition" do
      assert { subject.class == Ruby::MethodDefinition }
    end

    should "have constant receiver" do
      assert { subject.receiver.class == Ruby::Constant }
    end

    should "have receiver with token" do
      assert { subject.receiver.token == "Foo" }
    end

    should "have identifier" do
      assert { subject.identifier.class == Ruby::Identifier }
    end

    should "have identifier with token" do
      assert { subject.identifier.token == "bar" }
    end

    should "have param list" do
      assert { subject.parameters.class == Ruby::ParameterList }
    end

    should "have param list with size" do
      assert { subject.parameters.size == 2 }
    end

    should "have param list with left delim" do
      assert { subject.parameters.left_delim.token == "(" }
    end

    should "have param list with right delim" do
      assert { subject.parameters.right_delim.token == ")" }
    end
  end

  context "method def on self" do
    subject { statement " def self.bar(a, b)\n  puts 'bar'\nend" }

    should "be method definition" do
      assert { subject.class == Ruby::MethodDefinition }
    end

    should "have keyword receiver" do
      assert { subject.receiver.kind_of? Ruby::Keyword }
    end

    should "have self receiver" do
      assert { subject.receiver.class == Ruby::Self }
    end

    should "have receiver with token" do
      assert { subject.receiver.token == "self" }
    end

    should "have identifier" do
      assert { subject.identifier.class == Ruby::Identifier }
    end

    should "have identifier with token" do
      assert { subject.identifier.token == "bar" }
    end

    should "have param list" do
      assert { subject.parameters.class == Ruby::ParameterList }
    end

    should "have param list with size" do
      assert { subject.parameters.size == 2 }
    end

    should "have param list with left delim" do
      assert { subject.parameters.left_delim.token == "(" }
    end

    should "have param list with right delim" do
      assert { subject.parameters.right_delim.token == ")" }
    end
  end
end
