require File.expand_path("../test_helper", File.dirname(__FILE__))

class BlockTest < Test::Unit::TestCase
  context "block without parameters" do
    subject { statement("foo(a, b) { puts x }").block }

    should_be Ruby::Block
    should_have :parameters, Ruby::ParameterList
  end

  context "block with empty parameters" do
    subject { statement("foo(a, b) { || puts x }").block }

    should "have parameter list" do
      assert { subject.parameters.class == Ruby::ParameterList }
    end

    should "have parameter list with left delim" do
      assert { subject.parameters.left_delim.token == "|" }
    end

    should "have parameter list with right delim" do
      assert { subject.parameters.right_delim.token == "|" }
    end

    should "have parameter list with left delim position" do
      assert { subject.parameters.left_delim.position == pos(0, 12) }
    end

    should "have parameter list with right delim position" do
      assert { subject.parameters.right_delim.position == pos(0, 13) }
    end
  end

  context "block with empty parameters with space" do
    subject { statement("foo(a, b) { |  | puts x }").block }

    should "have parameter list" do
      assert { subject.parameters.class == Ruby::ParameterList }
    end

    should "have parameter list with left delim" do
      assert { subject.parameters.left_delim.token == "|" }
    end

    should "have parameter list with right delim" do
      assert { subject.parameters.right_delim.token == "|" }
    end

    should "have parameter list with left delim position" do
      assert { subject.parameters.left_delim.position == pos(0, 12) }
    end

    should "have parameter list with right delim position" do
      assert { subject.parameters.right_delim.position == pos(0, 15) }
    end
  end

  context "block with parameter" do
    subject { statement("foo(a, b) { |x| puts x }").block }

    should_be Ruby::Block

    should "have parameter list" do
      assert { subject.parameters.class == Ruby::ParameterList }
    end

    should "have parameter" do
      assert { subject.parameters.first.class == Ruby::Identifier }
    end

    should "have parameter with token" do
      assert { subject.parameters.first.token == "x" }
    end

    context "with excess comma" do
      subject { statement("foo(a, b) { |x, y, | puts x }").block }

      should "should have parameter list with size" do
        assert { subject.parameters.size == 2 }
      end
    end
  end

  context "block with default parameter" do
    subject { statement("foo(a, b) { |x, y = 3| puts x }").block }

    should "have parameter list" do
      assert { subject.parameters.class == Ruby::ParameterList }
    end

    should "have parameter" do
      assert { subject.parameters.last.class == Ruby::DefaultParameter }
    end

    should "have parameter with identifier" do
      assert { subject.parameters.last.identifier.class == Ruby::Identifier }
    end

    should "have parameter with token" do
      assert { subject.parameters.last.identifier.token == "y" }
    end
  end

  context "block with regular parameter after default parametr" do
    subject { statement("foo(a, b) { |x, y = 3, z| puts x }").block }

    should "have parameter with token" do
      assert { subject.parameters.last.token == "z" }
    end
  end

  context "block with only a default parameter" do
    subject { statement("foo(a, b) { |x = 3| puts x }").block }

    should "have default parameter" do
      assert { subject.parameters.first.class == Ruby::DefaultParameter }
    end

    should "have parameter with identifier" do
      assert { subject.parameters.first.identifier.class == Ruby::Identifier }
    end
  end

  context "block with splat parameter" do
    subject { statement("foo(a, b) { |x, *other| puts x }").block }

    should "have splat parameter" do
      assert { subject.parameters.last.class == Ruby::SplatParameter }
    end

    should "have splat parameter with identifier" do
      assert { subject.parameters.last.identifier.class == Ruby::Identifier }
    end

    should "have splat parameter with identifier with token" do
      assert { subject.parameters.last.identifier.token == "other" }
    end

    should "have splat parameter with left delim" do
      assert { subject.parameters.last.left_delim.token == "*" }
    end
  end

  context "block with block parameter" do
    subject { statement("foo(a, b) { |x, &block| puts x }").block }

    should "have block parameter" do
      assert { subject.parameters.last.class == Ruby::BlockParameter }
    end

    should "have block parameter with identifier" do
      assert { subject.parameters.last.identifier.class == Ruby::Identifier }
    end

    should "have block parameter with identifier with token" do
      assert { subject.parameters.last.identifier.token == "block" }
    end

    should "have block parameter with left delim" do
      assert { subject.parameters.last.left_delim.token == "&" }
    end
  end

  context "block without statements" do
    subject { statement("foo(a, b) { }").block }

    should "have statement list" do
      assert { subject.statements.class == Ruby::ExpressionList }
    end

    should "have no statements" do
      assert { subject.statements.elements == [] }
    end
  end

  context "block with statements" do
    subject { statement("foo(a, b) { foo\nbar; baz }").block }

    should "have statement list" do
      assert { subject.statements.class == Ruby::ExpressionList }
    end

    should "have statements" do
      assert { subject.statements.first.class == Ruby::Variable }
    end

    should "have statement list with size" do
      assert { subject.statements.size == 3 }
    end
  end

  context "block with do keyword" do
    subject { statement("foo(a, b) do |foo, bar = 3, baz = {}, *args, &block|\n  puts 'foo'\n  puts 'bar'\nend").block }

    should_be Ruby::Block

    should "have parameter list" do
      assert { subject.parameters.class == Ruby::ParameterList }
    end

    should "have parameter list with size" do
      assert { subject.parameters.size == 5 }
    end

    should "have statement list" do
      assert { subject.statements.class == Ruby::ExpressionList }
    end

    should "have statement list with size" do
      assert { subject.statements.size == 2 }
    end
  end
end
