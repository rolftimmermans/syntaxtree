require File.expand_path("../test_helper", File.dirname(__FILE__))

class KeywordTest < Test::Unit::TestCase
  class << self
    include SyntaxTree

    def should_be_keyword_call
      should "be keyword call" do
        assert { subject.class == Ruby::KeywordCall }
      end
    end

    def should_have_keyword
      should "have keyword" do
        assert { subject.keyword.class == Ruby::Keyword }
      end
    end

    def should_have_keyword_token(token)
      should "have keyword token" do
        assert { subject.keyword.token == token }
      end
    end

    def should_have_no_arguments
      should "have no argument list" do
        assert { subject.arguments == nil }
      end
    end

    def should_have_no_block
      should "have no block" do
        assert { subject.block == nil }
      end
    end
  end

  context "alias" do
    subject { statement "  alias one two" }

    should "be alias" do
      assert { subject.class == Ruby::Alias }
    end

    should_have_keyword
    should_have_keyword_token "alias"

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

    should_have_keyword
    should_have_keyword_token "alias"

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

  context "bare super" do
    subject { statement " super " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "super"
    should_have_no_arguments
    should_have_no_block
  end

  context "super without arguments" do
    subject { statement " super() " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "super"

    should "have argument list" do
      assert { subject.arguments.class == Ruby::ArgumentList }
    end

    should "have argument list with left delimiter" do
      assert { subject.arguments.left_delim.token == "(" }
    end

    should "have argument list with right delimiter" do
      assert { subject.arguments.right_delim.token == ")" }
    end

    should "have no block" do
      assert { subject.block == nil }
    end
  end

  context "super with arguments" do
    subject { statement " super(foo, bar) " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "super"

    should "have argument list" do
      assert { subject.arguments.class == Ruby::ArgumentList }
    end

    should "have argument list with left delimiter" do
      assert { subject.arguments.left_delim.token == "(" }
    end

    should "have argument list with right delimiter" do
      assert { subject.arguments.right_delim.token == ")" }
    end
  end

  context "super with block" do
    subject { statement " super { |a, b| puts 'foo' } " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "super"
    should_have_no_arguments

    should "have block" do
      assert { subject.block.class == Ruby::Block }
    end
  end

  context "bare yield" do
    subject { statement " yield " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "yield"
    should_have_no_arguments
    should_have_no_block
  end

  context "yield without arguments" do
    subject { statement " yield() " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "yield"

    should "have argument list" do
      assert { subject.arguments.class == Ruby::ArgumentList }
    end

    should "have argument list with left delimiter" do
      assert { subject.arguments.left_delim.token == "(" }
    end

    should "have argument list with right delimiter" do
      assert { subject.arguments.right_delim.token == ")" }
    end

    should "have no block" do
      assert { subject.block == nil }
    end
  end

  context "yield with arguments" do
    subject { statement " yield(foo, bar) " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "yield"

    should "have argument list" do
      assert { subject.arguments.class == Ruby::ArgumentList }
    end

    should "have argument list with left delimiter" do
      assert { subject.arguments.left_delim.token == "(" }
    end

    should "have argument list with right delimiter" do
      assert { subject.arguments.right_delim.token == ")" }
    end
  end

  context "bare return" do
    subject { statement " return " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "return"
    should_have_no_arguments
    should_have_no_block
  end

  context "return without argument" do
    subject { statement " return() " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "return"

    should "have argument list" do
      assert { subject.arguments.class == Ruby::Statements }
    end

    should "have argument list with left delimiter" do
      assert { subject.arguments.left_delim.token == "(" }
    end

    should "have argument list with right delimiter" do
      assert { subject.arguments.right_delim.token == ")" }
    end

    should "have no block" do
      assert { subject.block == nil }
    end
  end

  context "return with argument" do
    subject { statement " return(foo) " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "return"

    should "have argument list" do
      assert { subject.arguments.class == Ruby::Statements }
    end

    should "have argument list with left delimiter" do
      assert { subject.arguments.left_delim.token == "(" }
    end

    should "have argument list with right delimiter" do
      assert { subject.arguments.right_delim.token == ")" }
    end

    context "with spaces before argument" do
      subject { statement " return  (foo) " }

      should "have argument list" do
        assert { subject.arguments.class == Ruby::Statements }
      end

      should "have argument list with left delimiter" do
        assert { subject.arguments.left_delim.token == "(" }
      end

      should "have argument list with right delimiter" do
        assert { subject.arguments.right_delim.token == ")" }
      end
    end
  end

  # context "return with multiple arguments" do
  #   subject { statement " return(foo, bar) " }
  #
  #   should "be keyword call" do
  #     assert { subject.class == Ruby::KeywordCall }
  #   end
  #
  #   should "have keyword" do
  #     assert { subject.keyword.class == Ruby::Keyword }
  #   end
  #
  #   should "have keyword token" do
  #     assert { subject.keyword.token == "return" }
  #   end
  #
  #   should "have argument list" do
  #     assert { subject.arguments.class == Ruby::ArgumentList }
  #   end
  #
  #   should "have argument list with left delimiter" do
  #     assert { subject.arguments.left_delim.token == "(" }
  #   end
  #
  #   should "have argument list with right delimiter" do
  #     assert { subject.arguments.right_delim.token == ")" }
  #   end
  # end

  context "bare next" do
    subject { statement " next " }

    should_be_keyword_call
    should_have_keyword
    should_have_keyword_token "next"
    should_have_no_arguments
    should_have_no_block
  end
end
