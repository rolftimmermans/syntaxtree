require File.expand_path("../test_helper", File.dirname(__FILE__))

class KeywordTest < Test::Unit::TestCase
  context "alias" do
    subject { expression "  alias one two" }

    should "be alias" do
      assert { subject.class == Ruby::Alias }
    end

    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "alias"

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
    subject { expression "  alias $one $two" }

    should "be alias" do
      assert { subject.class == Ruby::Alias }
    end

    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "alias"

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
    subject { expression " super " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "super"
    should_not_have :arguments
    should_not_have :block
  end

  context "super without arguments" do
    subject { expression " super() " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "super"

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
    subject { expression " super(foo, bar) " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "super"

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
    subject { expression " super { |a, b| puts 'foo' } " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "super"
    should_not_have :arguments

    should "have block" do
      assert { subject.block.class == Ruby::Block }
    end
  end

  context "bare yield" do
    subject { expression " yield " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "yield"
    should_not_have :arguments
    should_not_have :block
  end

  context "yield without arguments" do
    subject { expression " yield() " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "yield"

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
    subject { expression " yield(foo, bar) " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "yield"

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
    subject { expression " return " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "return"
    should_not_have :arguments
    should_not_have :block
  end

  context "return without argument" do
    subject { expression " return() " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "return"

    should "have argument list" do
      assert { subject.arguments.class == Ruby::ExpressionList }
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
    subject { expression " return(foo) " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "return"

    should "have argument list" do
      assert { subject.arguments.class == Ruby::ExpressionList }
    end

    should "have argument list with left delimiter" do
      assert { subject.arguments.left_delim.token == "(" }
    end

    should "have argument list with right delimiter" do
      assert { subject.arguments.right_delim.token == ")" }
    end

    context "with spaces before argument" do
      subject { expression " return  (foo) " }

      should "have argument list" do
        assert { subject.arguments.class == Ruby::ExpressionList }
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
  #   subject { expression " return(foo, bar) " }
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
    subject { expression " next " }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "next"
    should_not_have :arguments
    should_not_have :block
  end

  # break

  # redo

  # retry

  context "begin" do
    subject { expression " BEGIN { puts 'foo'; puts 'bar' }" }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "BEGIN"
    should_have :block, Ruby::Block

    context "block" do
      subject { expression(" BEGIN { puts 'foo'; puts 'bar' }").block }

      should_have_expressions 2
      should_have_delimiters "{", "}"
    end
  end

  context "end" do
    subject { expression " END { puts 'foo'; puts 'bar' }" }

    should_be Ruby::KeywordCall
    should_have :keyword, Ruby::Keyword
    should_have_with_token :keyword, "END"
    should_have :block, Ruby::Block

    context "block" do
      subject { expression(" END { puts 'foo'; puts 'bar' }").block }

      should_have_expressions 2
      should_have_delimiters "{", "}"
    end
  end
end
