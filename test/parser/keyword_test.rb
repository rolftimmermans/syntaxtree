require File.expand_path("../test_helper", File.dirname(__FILE__))

class KeywordTest < Test::Unit::TestCase
  context "nil" do
    subject { statement "  nil" }

    should_be Ruby::Nil
    should_be_kind_of Ruby::Keyword

    should "have nil value" do
      assert { subject.value == nil }
    end

    should "have position" do
      assert { subject.position == pos(0, 2) }
    end
  end

  context "true" do
    subject { statement "  true" }

    should_be Ruby::True
    should_be_kind_of Ruby::Keyword

    should "have true value" do
      assert { subject.value == true }
    end

    should "have position" do
      assert { subject.position == pos(0, 2) }
    end

    should "have prologue" do
      assert { subject.prologue.first.token == "  " }
    end
  end

  context "false" do
    subject { statement "  false" }

    should_be Ruby::False
    should_be_kind_of Ruby::Keyword

    should "have false value" do
      assert { subject.value == false }
    end

    should "have position" do
      assert { subject.position == pos(0, 2) }
    end

    should "have prologue" do
      assert { subject.prologue.first.token == "  " }
    end
  end

  context "self" do
    subject { statement "  self" }

    should_be Ruby::Self
    should_be_kind_of Ruby::Keyword

    should "have position" do
      assert { subject.position == pos(0, 2) }
    end

    should "have prologue" do
      assert { subject.prologue.first.token == "  " }
    end
  end
end
