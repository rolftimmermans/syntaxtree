require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyKeywordCallTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert alias with identifiers" do
      src = "alias foo bar"
      assert { to_ruby(src) == src }
    end

    should "convert alias with symbols" do
      src = "alias :foo :bar"
      assert { to_ruby(src) == src }
    end

    should "convert alias with global variables" do
      src = "alias $PATH $:"
      assert { to_ruby(src) == src }
    end

    should "convert bare super" do
      src = " super"
      assert { to_ruby(src) == src }
    end

    should "convert super without arguments" do
      src = " super( )"
      assert { to_ruby(src) == src }
    end

    should "convert super with arguments" do
      src = " super(1, 2, *args)"
      assert { to_ruby(src) == src }
    end

    should "convert super with arguments without parentheses" do
      src = " super 1, 2, *args"
      assert { to_ruby(src) == src }
    end

    should "convert super with block" do
      src = " super() do |a, b|\n  puts 'foo'\nend"
      assert { to_ruby(src) == src }
    end

    should "convert bare yield" do
      src = " yield"
      assert { to_ruby(src) == src }
    end

    should "convert yield without arguments" do
      src = " yield( )"
      assert { to_ruby(src) == src }
    end

    should "convert yield with arguments" do
      src = " yield(1, 2, *args)"
      assert { to_ruby(src) == src }
    end

    should "convert yield with arguments without parentheses" do
      src = " yield 1, 2, *args"
      assert { to_ruby(src) == src }
    end

    should "convert bare return" do
      src = " return "
      assert { to_ruby(src) == src }
    end

    should "convert return without argument" do
      src = " return( ) "
      assert { to_ruby(src) == src }
    end

    should "convert return with argument" do
      src = " return(1 )"
      assert { to_ruby(src) == src }
    end

    should "convert return with arguments without parentheses" do
      src = " return 1, 2, *args"
      assert { to_ruby(src) == src }
    end
  end
end
