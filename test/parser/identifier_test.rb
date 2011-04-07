require File.expand_path("../test_helper", File.dirname(__FILE__))

class IdentifierTest < Test::Unit::TestCase
  context "variable" do
    subject { statement "foo" }

    should "be identifier" do
      assert { subject.kind_of? Ruby::Identifier }
    end

    should "be variable" do
      assert { subject.class == Ruby::Variable }
    end

    should "have token" do
      assert { subject.token == "foo" }
    end
  end

  context "instance variable" do
    subject { statement "@foo" }

    should "be identifier" do
      assert { subject.kind_of? Ruby::Identifier }
    end

    should "be instance variable" do
      assert { subject.class == Ruby::InstanceVariable }
    end

    should "have token" do
      assert { subject.token == "@foo" }
    end
  end

  context "class variable" do
    subject { statement "@@foo" }

    should "be identifier" do
      assert { subject.kind_of? Ruby::Identifier }
    end

    should "be class variable" do
      assert { subject.class == Ruby::ClassVariable }
    end

    should "have token" do
      assert { subject.token == "@@foo" }
    end
  end

  context "global variable" do
    subject { statement "$foo" }

    should "be identifier" do
      assert { subject.kind_of? Ruby::Identifier }
    end

    should "be global variable" do
      assert { subject.class == Ruby::GlobalVariable }
    end

    should "have token" do
      assert { subject.token == "$foo" }
    end
  end
end
