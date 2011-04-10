require File.expand_path("../test_helper", File.dirname(__FILE__))

class ClassTest < Test::Unit::TestCase
  context "empty class" do
    subject { statement "class Foo; end" }

    should_be Ruby::Class
    should_have_delimiters "class", "end"

    should "have constant identifier" do
      assert { subject.identifier.class == Ruby::Constant }
    end

    should "have constant identifier with given name" do
      assert { subject.identifier.token == "Foo" }
    end

    should "have expressions attribute" do
      assert { subject.expressions.class == Ruby::ExpressionList }
    end

    should "have no expressions" do
      assert { subject.expressions.elements == [] }
    end

    should "have no operator" do
      assert { subject.operator == nil }
    end

    should "have no superclass" do
      assert { subject.superclass == nil }
    end
  end

  context "class with expressions" do
    subject { statement "class Foo; define_foo; define_bar; 3; end" }

    should_be Ruby::Class

    should "have expressions attribute" do
      assert { subject.expressions.class == Ruby::ExpressionList }
    end

    should "have expressions" do
      assert { subject.expressions.first.class == Ruby::Variable }
    end

    should "have correct statement length" do
      assert { subject.expressions.size == 3 }
    end
  end

  context "namespaced class" do
    subject { statement "class Foo::Bar::Baz::Qux; end" }

    should_be Ruby::Class
    should_have :identifier, Ruby::Namespace

    should "have namespace with constant" do
      assert { subject.identifier.first.class == Ruby::Constant }
    end

    should "have namespace with constant names" do
      assert { subject.identifier.map(&:token) == ["Foo", "Bar", "Baz", "Qux"] }
    end
  end

  context "child class" do
    subject { statement "class Foo < Bar; end" }

    should_be Ruby::Class
    should_have :superclass, Ruby::Constant

    should "have superclass with correct token" do
      assert { subject.superclass.token == "Bar" }
    end

    should "have operator" do
      assert { subject.operator.token == "<" }
    end
  end

  context "metaclass" do
    subject { statement "class << foo_bar; define_foo; def xyz(); end; end" }

    should "be class" do
      assert { subject.kind_of? Ruby::Class }
    end

    should_be Ruby::MetaClass
    should_have_delimiters "class", "end"

    should "have operator" do
      assert { subject.operator.token == "<<" }
    end

    should "have identifier" do
      assert { subject.identifier.class == Ruby::Variable }
    end

    should "have identifier with given name" do
      assert { subject.identifier.token == "foo_bar" }
    end

    should "have expressions" do
      assert { subject.expressions.first.class == Ruby::Variable }
    end

    should "have correct statement length" do
      assert { subject.expressions.size == 2 }
    end
  end

  context "singleton class" do
    subject { statement "class << self; end" }

    should "be class" do
      assert { subject.kind_of? Ruby::Class }
    end

    should_be Ruby::MetaClass
    should_have :identifier, Ruby::Self
  end
end
