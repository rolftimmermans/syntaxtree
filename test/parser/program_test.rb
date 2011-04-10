require File.expand_path("../test_helper", File.dirname(__FILE__))

class ProgramTest < Test::Unit::TestCase
  context "empty source" do
    subject { parse "" }

    should "be program" do
      assert { subject.class == Ruby::Program }
    end

    should "have statement list" do
      assert { subject.statements.class == Ruby::ExpressionList }
    end

    should "have no statements" do
      assert { subject.statements.empty? }
    end
  end

  context "whitespace source" do
    subject { parse "  \n\t " }

    should "be program" do
      assert { subject.class == Ruby::Program }
    end

    should "have no statements" do
      assert { subject.statements.empty? }
    end

    should "have epilogue" do
      assert { subject.epilogue.to_s == "  \n\t " }
    end
  end

  context "program with statement" do
    subject { parse "foo" }

    should "have identifier" do
      assert { subject.statements.first.class == Ruby::Variable }
    end
  end

  context "program with semicolons" do
    subject { parse "foo; foo" }

    should "have identifier" do
      assert { subject.statements.first.class == Ruby::Variable }
    end

    should "have identifier with prologue" do
      assert { subject.statements.last.prologue.to_s == "; " }
    end
  end

  context "program with multiple semicolons" do
    subject { parse "foo;;; foo" }

    should "have identifier with prologue" do
      assert { subject.statements.last.prologue.to_s == ";;; " }
    end
  end

  context "program with trailing semicolon" do
    subject { parse "foo; foo ; " }

    should "have epilogue" do
      assert { subject.epilogue.to_s == " ; " }
    end
  end

  context "program with statement on multiple lines" do
    subject { parse "foo \\\nbar" }

    should "have one statement" do
      assert { subject.statements.size == 1 }
    end
  end
end
