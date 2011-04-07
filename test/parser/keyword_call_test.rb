require File.expand_path("../test_helper", File.dirname(__FILE__))

class KeywordTest < Test::Unit::TestCase
  context "alias" do
    subject { statement "  alias one two" }

    should "be alias" do
      assert { subject.class == Ruby::Alias }
    end

    should "have keyword" do
      assert { subject.keyword.class == Ruby::Keyword }
    end

    should "have keyword token" do
      assert { subject.keyword.token == "alias" }
    end

    should "have alias" do
      assert { subject.alias.class == Ruby::Identifier }
    end

    should "have alias token" do
      assert { subject.alias.token == "one" }
    end

    should "have original" do
      assert { subject.original.class == Ruby::Identifier }
    end

    should "have original token" do
      assert { subject.original.token == "two" }
    end
  end

  context "variable alias" do
    subject { statement "  alias $one $two" }

    should "be alias" do
      assert { subject.class == Ruby::Alias }
    end

    should "have keyword" do
      assert { subject.keyword.class == Ruby::Keyword }
    end

    should "have keyword token" do
      assert { subject.keyword.token == "alias" }
    end

    should "have alias" do
      assert { subject.alias.class == Ruby::GlobalVariable }
    end

    should "have alias token" do
      assert { subject.alias.token == "$one" }
    end

    should "have original" do
      assert { subject.original.class == Ruby::GlobalVariable }
    end

    should "have original token" do
      assert { subject.original.token == "$two" }
    end
  end
end
