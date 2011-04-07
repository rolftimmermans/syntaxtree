require File.expand_path("../test_helper", File.dirname(__FILE__))

class KeywordTest < Test::Unit::TestCase
  context "nil" do
    subject { statement "  nil" }

    should "be keyword" do
      assert { subject.kind_of? Ruby::Keyword }
    end

    should "be nil" do
      assert { subject.class == Ruby::Nil }
    end

    should "have nil value" do
      assert { subject.value == nil }
    end

    should "have position" do
      assert { subject.position == pos(0, 2) }
    end
  end

  context "true" do
    subject { statement "  true" }

    should "be keyword" do
      assert { subject.kind_of? Ruby::Keyword }
    end

    should "be true" do
      assert { subject.class == Ruby::True }
    end

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

    should "be keyword" do
      assert { subject.kind_of? Ruby::Keyword }
    end

    should "be false" do
      assert { subject.class == Ruby::False }
    end

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

    should "be keyword" do
      assert { subject.kind_of? Ruby::Keyword }
    end

    should "be self" do
      assert { subject.class == Ruby::Self }
    end

    should "have position" do
      assert { subject.position == pos(0, 2) }
    end

    should "have prologue" do
      assert { subject.prologue.first.token == "  " }
    end
  end
end
