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

    should "have left delim" do
      assert { subject.left_delim.token == "def" }
    end

    should "have right delim" do
      assert { subject.right_delim.token == "end" }
    end
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

    should "have list with right delim" do
      assert { subject.parameters.right_delim.token == ")" }
    end
  end

  context "method def with statements" do
    subject { statement "def foo(a, b)\n  puts 'foo'; puts b\n end" }

    should "have statements" do
      assert { subject.statements.class == Ruby::Statements }
    end

    should "have statements with size" do
      assert { subject.statements.size == 2 }
    end
  end
end
