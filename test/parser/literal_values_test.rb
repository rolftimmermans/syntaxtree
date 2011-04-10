require File.expand_path("../test_helper", File.dirname(__FILE__))

class LiteralValuesTest < Test::Unit::TestCase
  context "integer" do
    subject { expression "  123" }

    should "be literal" do
      assert { subject.kind_of? Ruby::Literal }
    end

    should "be integer" do
      assert { subject.class == Ruby::Integer }
    end

    should "have integer value" do
      assert { subject.value == 123 }
    end

    should "have position" do
      assert { subject.position == pos(0, 2) }
    end

    should "have prologue" do
      assert { subject.prologue.first.token == "  " }
    end
  end

  context "float" do
    subject { expression "  1.23" }

    should "be literal" do
      assert { subject.kind_of? Ruby::Literal }
    end

    should "be float" do
      assert { subject.class == Ruby::Float }
    end

    should "have float value" do
      assert { subject.value == 1.23 }
    end

    should "have position" do
      assert { subject.position == pos(0, 2) }
    end

    should "have prologue" do
      assert { subject.prologue.first.token == "  " }
    end
  end

  context "character" do
    subject { expression " ?x" }

    should "be literal" do
      assert { subject.kind_of? Ruby::Literal }
    end

    should "be character" do
      assert { subject.class == Ruby::Character }
    end

    should "have character value" do
      assert { subject.value == ?x }
    end

    should "have position" do
      assert { subject.position == pos(0, 1) }
    end

    should "have prologue" do
      assert { subject.prologue.first.token == " " }
    end
  end

  context "label" do
    subject { expression("{  label: bar }").first }

    should "be literal" do
      assert { subject.key.kind_of? Ruby::Literal }
    end

    should "be label" do
      assert { subject.key.class == Ruby::Label }
    end

    should "have token" do
      assert { subject.key.token == "label:" }
    end

    should "have symbol value" do
      assert { subject.key.value == :label }
    end

    should "have position" do
      assert { subject.key.position == pos(0, 3) }
    end

    should "have prologue" do
      assert { subject.key.prologue.first.token == "  " }
    end
  end
end
