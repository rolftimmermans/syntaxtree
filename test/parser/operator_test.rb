require File.expand_path("../test_helper", File.dirname(__FILE__))

class OperatorTest < Test::Unit::TestCase
  context "unary keyword operator" do
    subject { statement "not foo" }

    should "be unary operator" do
      assert { subject.class == Ruby::UnaryOperator }
    end

    should "have operator" do
      assert { subject.operator.class == Ruby::Keyword }
    end

    should "have operator with token" do
      assert { subject.operator.token == "not" }
    end

    should "have right side" do
      assert { subject.right.token == "foo" }
    end
  end

  context "unary token operator" do
    subject { statement "!foo" }

    should "be unary operator" do
      assert { subject.class == Ruby::UnaryOperator }
    end

    should "have operator" do
      assert { subject.operator.class == Ruby::Token }
    end

    should "have operator with token" do
      assert { subject.operator.token == "!" }
    end

    should "have right side" do
      assert { subject.right.token == "foo" }
    end
  end

  context "binary keyword operator" do
    subject { statement "foo or bar" }

    should "be binary operator" do
      assert { subject.class == Ruby::BinaryOperator }
    end

    should "have left side" do
      assert { subject.left.token == "foo" }
    end

    should "have operator" do
      assert { subject.operator.class == Ruby::Keyword }
    end

    should "have operator with token" do
      assert { subject.operator.token == "or" }
    end

    should "have right side" do
      assert { subject.right.token == "bar" }
    end
  end

  context "binary token operator" do
    subject { statement "foo && bar" }

    should "be binary operator" do
      assert { subject.class == Ruby::BinaryOperator }
    end

    should "have left side" do
      assert { subject.left.token == "foo" }
    end

    should "have operator" do
      assert { subject.operator.class == Ruby::Token }
    end

    should "have operator with token" do
      assert { subject.operator.token == "&&" }
    end

    should "have right side" do
      assert { subject.right.token == "bar" }
    end
  end
end
