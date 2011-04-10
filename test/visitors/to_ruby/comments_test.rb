require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyCommentsTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert comments preceding expression" do
      src = "  # comment\n  # line two\n  #line three\n  expression"
      assert { to_ruby(src) == src }
    end

    should "convert comments after expression" do
      src = " expression # comment \n stmt # another comment"
      assert { to_ruby(src) == src }
    end

    should "convert comments following expression" do
      src = "  expression\n  # comment \n  # another"
      assert { to_ruby(src) == src }
    end

    should "convert magic comment" do
      src = "# -*- encoding: UTF-8 -*-\nexpression"
      assert { to_ruby(src) == src }
    end

    should "convert multiline comment" do
      src = "=begin\nOne\nTwo\nThree\n=end"
      assert { to_ruby(src) == src }
    end
  end
end
