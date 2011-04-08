require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyIdentifierTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert variables" do
      src = "foo; bar\nbaz"
      assert { to_ruby(src) == src }
    end

    should "convert instance variables" do
      src = "@foo; @bar\n@baz"
      assert { to_ruby(src) == src }
    end

    should "convert class variables" do
      src = "@@foo; @@bar\n@@baz"
      assert { to_ruby(src) == src }
    end

    should "convert global variables" do
      src = "$foo; $bar\n$baz"
      assert { to_ruby(src) == src }
    end
  end
end
