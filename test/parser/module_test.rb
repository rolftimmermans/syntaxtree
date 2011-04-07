require File.expand_path("../test_helper", File.dirname(__FILE__))

class ModuleTest < Test::Unit::TestCase
  context "empty module" do
    subject { statement "module Foo; end" }

    should "be module" do
      assert { subject.class == Ruby::Module }
    end

    should "have left delimiter" do
      assert { subject.left_delim.token == "module" }
    end

    should "have right delimiter" do
      assert { subject.right_delim.token == "end" }
    end

    should "have constant identifier" do
      assert { subject.identifier.class == Ruby::Constant }
    end

    should "have constant identifier with given name" do
      assert { subject.identifier.token == "Foo" }
    end

    should "have statements attribute" do
      assert { subject.statements.class == Ruby::Statements }
    end

    should "have no statements" do
      assert { subject.statements.elements == [] }
    end
  end

  context "module with statements" do
    subject { statement "module Foo; define_foo; define_bar; 3; end" }

    should "be module" do
      assert { subject.class == Ruby::Module }
    end

    should "have statements attribute" do
      assert { subject.statements.class == Ruby::Statements }
    end

    should "have statements" do
      assert { subject.statements.first.class == Ruby::Variable }
    end

    should "have correct statement length" do
      assert { subject.statements.size == 3 }
    end
  end

  context "namespaced module" do
    subject { statement "module Foo::Bar::Baz::Qux; end" }

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
