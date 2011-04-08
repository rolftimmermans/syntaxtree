require File.expand_path("../test_helper", File.dirname(__FILE__))

class CommentsTest < Test::Unit::TestCase
  context "commented statement" do
    subject { statement "# One two\n# Three four\n\ndef foo; end" }

    setup do
      @comments = subject.left_delim.prologue.select { |c| c.kind_of? Ruby::Comment }
    end

    should "have prologue" do
      assert { subject.left_delim.prologue.size == 3 }
    end

    should "have comments in prologue" do
      assert { @comments.size == 2 }
    end

    should "have comment in prologue" do
      assert { @comments.first.class == Ruby::Comment }
    end

    should "have comment with tokens in prologue" do
      tokens = @comments.map(&:token)
      assert { tokens == ["# One two\n", "# Three four\n"] }
    end
  end

  context "statement with multiline comment" do
    subject { statement "=begin\nOne two\nThree four\n=end\n\ndef foo; end" }

    setup do
      @comments = subject.left_delim.prologue.select { |c| c.kind_of? Ruby::Comment }
    end

    should "have prologue" do
      assert { subject.left_delim.prologue.size == 5 }
    end

    should "have comments in prologue" do
      assert { @comments.size == 4 }
    end

    should "have comment in prologue" do
      assert { @comments.first.class == Ruby::Comment }
    end

    should "have comment with tokens in prologue" do
      tokens = @comments.map(&:token)
      assert { tokens == ["=begin\n", "One two\n", "Three four\n", "=end\n"] }
    end
  end
end
