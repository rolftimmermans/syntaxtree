require File.expand_path("../test_helper", File.dirname(__FILE__))

class ClassTest < Test::Unit::TestCase
  context "empty class" do
    subject { statement "class Foo; end" }

    should "be class" do
      assert { subject.kind_of? Ruby::Class }
    end

    should "have left delimiter" do
      assert { subject.left_delim.token == "class" }
    end

    should "have right delimiter" do
      assert { subject.right_delim.token == "end" }
    end

    should "have constant identifier" do
      assert { subject.identifier.kind_of? Ruby::Constant }
    end

    should "have constant identifier with given name" do
      assert { subject.identifier.token == "Foo" }
    end

    should "have statements attribute" do
      assert { subject.statements.kind_of? Ruby::Statements }
    end

    should "have no statements" do
      assert { subject.statements.elements == [] }
    end

    should "have no operator" do
      assert { subject.operator == nil }
    end

    should "have no superclass" do
      assert { subject.superclass == nil }
    end
  end

  context "class with statements" do
    subject { statement "class Foo; define_foo; define_bar; 3; end" }

    should "be class" do
      assert { subject.kind_of? Ruby::Class }
    end

    should "have statements attribute" do
      assert { subject.statements.kind_of? Ruby::Statements }
    end

    should "have statements" do
      assert { subject.statements.first.kind_of? Ruby::Identifier }
    end

    should "have correct statement length" do
      assert { subject.statements.size == 3 }
    end
  end

  context "namespaced class" do
    subject { statement "class Foo::Bar::Baz::Qux; end" }

    should "be class" do
      assert { subject.kind_of? Ruby::Class }
    end

    should "have namespace" do
      assert { subject.identifier.kind_of? Ruby::Namespace }
    end

    should "have namespace with constant" do
      assert { subject.identifier.first.kind_of? Ruby::Constant }
    end

    should "have namespace with constant names" do
      assert { subject.identifier.map(&:token) == ["Foo", "Bar", "Baz", "Qux"] }
    end
  end

  context "child class" do
    subject { statement "class Foo < Bar; end" }

    should "be class" do
      assert { subject.kind_of? Ruby::Class }
    end

    should "have superclass" do
      assert { subject.superclass.kind_of? Ruby::Constant }
    end

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

    should "be metaclass" do
      assert { subject.kind_of? Ruby::MetaClass }
    end

    should "have left delimiter" do
      assert { subject.left_delim.token == "class" }
    end

    should "have right delimiter" do
      assert { subject.right_delim.token == "end" }
    end

    should "have operator" do
      assert { subject.operator.token == "<<" }
    end

    should "have identifier" do
      assert { subject.identifier.kind_of? Ruby::Identifier }
    end

    should "have identifier with given name" do
      assert { subject.identifier.token == "foo_bar" }
    end

    should "have statements" do
      assert { subject.statements.first.kind_of? Ruby::Identifier }
    end

    should "have correct statement length" do
      assert { subject.statements.size == 2 }
    end
  end

  context "singleton class" do
    subject { statement "class << self; end" }

    should "be class" do
      assert { subject.kind_of? Ruby::Class }
    end

    should "be metaclass" do
      assert { subject.kind_of? Ruby::MetaClass }
    end

    should "have identifier" do
      assert { subject.identifier.kind_of? Ruby::Self }
    end
  end
end
