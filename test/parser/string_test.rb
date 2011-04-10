require File.expand_path("../test_helper", File.dirname(__FILE__))

class StringTest < Test::Unit::TestCase
  context "string" do
    subject { statement "'abc'" }

    should "be string" do
      assert { subject.class == Ruby::String }
    end

    should_have_delimiters "'", "'"

    should "have left delim at correct position" do
      assert { subject.left_delim.position == pos(0, 0) }
    end

    should "have right delim at correct position" do
      assert { subject.right_delim.position == pos(0, 4) }
    end

    should "have string contents" do
      assert { subject.contents.class == Ruby::StringContents }
    end

    should "have string contents with elements" do
      assert { subject.contents.elements.kind_of? Array }
    end

    should "have string contents with string value" do
      assert { subject.contents.first.token == "abc" }
    end

    context "spanning multiple lines" do
      subject { statement "'abc\ndef\nghi'" }

      should "have string value" do
        assert { subject.contents.inject("") { |s, l| s << l.token } == "abc\ndef\nghi" }
      end
    end
  end

  context "quoted string" do
    subject { statement "%Q{abc}" }

    should_have_delimiters "%Q{", "}"
  end

  context "interpolated string" do
    subject { statement '"my #{foo; bar; baz}"' }

    should "have left delim" do
      assert { subject.left_delim.token == '"' }
    end

    should "have right delim" do
      assert { subject.right_delim.token == '"' }
    end

    should "have string contents" do
      assert { subject.contents.class == Ruby::StringContents }
    end

    should "have string part" do
      assert { subject.contents.first.class == Ruby::StringPart }
    end

    should "have string value" do
      assert { subject.contents.first.token == "my " }
    end

    should "have embedded expression" do
      assert { subject.contents.last.class == Ruby::EmbeddedExpression }
    end

    should "have statement in expression" do
      assert { subject.contents.last.expressions.first.token == "foo" }
    end

    should "have embedded expression with left delimiter" do
      assert { subject.contents.last.left_delim.token == '#{' }
    end

    should "have embedded expression with right delimiter" do
      assert { subject.contents.last.right_delim.token == '}' }
    end

    should "have correct expressions size in expression" do
      assert { subject.contents.last.expressions.size == 3 }
    end
  end

  context "interpolated variable in string" do
    subject { statement '"my #@foo"' }

    should "have embedded variable" do
      assert { subject.contents.last.class == Ruby::EmbeddedVariable }
    end

    should "have embedded variable with left delimier" do
      assert { subject.contents.last.left_delim.token == "#" }
    end

    should "have embedded variable with identifier" do
      assert { subject.contents.last.identifier.token == "@foo" }
    end
  end
end
