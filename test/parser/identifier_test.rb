require File.expand_path("../test_helper", File.dirname(__FILE__))

class IdentifierTest < Test::Unit::TestCase
  context "variable" do
    subject { expression "foo" }

    should_be Ruby::Variable
    should_be_kind_of Ruby::Identifier
    should_have_token "foo"
  end

  context "instance variable" do
    subject { expression "@foo" }

    should_be Ruby::InstanceVariable
    should_be_kind_of Ruby::Identifier
    should_have_token "@foo"
  end

  context "class variable" do
    subject { expression "@@foo" }

    should_be Ruby::ClassVariable
    should_be_kind_of Ruby::Identifier
    should_have_token "@@foo"
  end

  context "global variable" do
    subject { expression "$foo" }

    should_be Ruby::GlobalVariable
    should_be_kind_of Ruby::Identifier
    should_have_token "$foo"
  end

  context "back reference" do
    subject { expression "$1" }

    should_be Ruby::GlobalVariable
    should_be_kind_of Ruby::Identifier
    should_have_token "$1"
  end
end
