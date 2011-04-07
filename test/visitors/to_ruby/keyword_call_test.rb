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
  end
end
