require File.expand_path("../test_helper", File.dirname(__FILE__))

class ModuleTest < Test::Unit::TestCase
  context "empty module" do
    subject { expression "module Foo; end" }

    should "be module" do
      assert { subject.class == Ruby::Module }
    end

    should_have_delimiters "module", "end"

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
  end

  context "module with expressions" do
    subject { expression "module Foo; define_foo; define_bar; 3; end" }

    should "be module" do
      assert { subject.class == Ruby::Module }
    end

    should "have expressions attribute" do
      assert { subject.expressions.class == Ruby::ExpressionList }
    end

    should "have expressions" do
      assert { subject.expressions.first.class == Ruby::Variable }
    end

    should "have correct expression length" do
      assert { subject.expressions.size == 3 }
    end
  end

  context "namespaced module" do
    subject { expression "module Foo::Bar::Baz::Qux; end" }

    should "be module" do
      assert { subject.class == Ruby::Module }
    end

    should "have namespace" do
      assert { subject.identifier.class == Ruby::Namespace }
    end

    should "have namespace with constant" do
      assert { subject.identifier.first.class == Ruby::Constant }
    end

    should "have namespace with constant names" do
      assert { subject.identifier.map(&:token) == ["Foo", "Bar", "Baz", "Qux"] }
    end
  end
end
