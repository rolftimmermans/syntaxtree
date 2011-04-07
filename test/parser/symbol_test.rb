require File.expand_path("../test_helper", File.dirname(__FILE__))

class SymbolTest < Test::Unit::TestCase
  context "symbol" do
    subject { statement "  :abc" }

    should "be literal" do
      assert { subject.kind_of? Ruby::Literal }
    end

    should "be symbol" do
      assert { subject.class == Ruby::Symbol }
    end

    should "have symbol value" do
      assert { subject.value == :abc }
    end

    should "have left delimiter" do
      assert { subject.left_delim.token == ":" }
    end

    should "have prologue" do
      assert { subject.left_delim.prologue.first.token == "  " }
    end
  end

  context "dynamic symbol" do
    subject { statement ':"my #{foo}"' }

    should "be dynamic symbol" do
      assert { subject.class == Ruby::DynamicSymbol }
    end

    should "have string contents" do
      assert { subject.contents.class == Ruby::StringContents }
    end

    should "have string part" do
      assert { subject.contents.first.class == Ruby::StringPart }
    end

    should "have string part with token" do
      assert { subject.contents.first.token == "my " }
    end

    should "have embedded expression" do
      assert { subject.contents.elements[1].class == Ruby::EmbeddedExpression }
    end

    should "have statement in expression" do
      assert { subject.contents.elements[1].statements.first.token == "foo" }
    end
  end
end
