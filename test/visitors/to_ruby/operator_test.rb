require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyOperatorTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert binary keyword operators" do
      src = " foo or bar and baz "
      assert { to_ruby(src) == src }
    end

    should "convert binary token operators" do
      src = " foo || bar && baz + qux - quux << corge * grault / garply % waldo ** fred & plugh | xyzzy ^ thud >> zork && gork || bork "
      assert { to_ruby(src) == src }
    end
  end
end
