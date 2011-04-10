module TestMacros
  include SyntaxTree

  # Support declarative specification of test methods.
  def test(name) # FIXME: Remove this.
    define_method "test_#{name.gsub(/\s+/,'_')}".to_sym, &Proc.new
  end

  def should_be(klass)
    should "be a #{klass}" do
      assert { subject.class == klass }
    end
  end

  def should_be_kind_of(klass)
    should "be a #{klass}" do
      assert { subject.kind_of? klass }
    end
  end

  def should_have_token(token)
    should "have token '#{token}'" do
      assert { subject.token == token }
    end
  end

  def should_have(name, klass)
    should "have #{name}" do
      assert { subject.send(name).class == klass }
    end
  end

  def should_not_have(name)
    should "not have #{name}" do
      assert { subject.send(name) == nil }
    end
  end

  def should_have_with_token(name, token)
    should "have #{name} with token '#{token}'" do
      assert { subject.send(name).token == token }
    end
  end

  def should_have_left_delimiter(glyph)
    should "have left delimiter" do
      assert { subject.left_delim.kind_of? Ruby::Token }
    end

    should "have left delimiter with correct glyph" do
      assert { subject.left_delim.token == glyph }
    end
  end

  def should_have_right_delimiter(glyph)
    should "have right delimiter" do
      assert { subject.right_delim.kind_of? Ruby::Token }
    end

    should "have right delimiter with correct glyph" do
      assert { subject.right_delim.token == glyph }
    end
  end

  def should_have_delimiters(left, right)
    should_have_left_delimiter left
    should_have_right_delimiter right
  end

  def should_have_expressions(amount)
    should_have :expressions, Ruby::ExpressionList
    should "have expressions with correct size" do
      assert { subject.expressions.size == amount }
    end
  end

  def should_have_expressions_with_left_delimiter(glyph)
    should "have expressions with left delimiter" do
      assert { subject.expressions.left_delim.kind_of? Ruby::Token }
    end

    should "have expressions with left delimiter with correct glyph" do
      assert { subject.expressions.left_delim.token == glyph }
    end
  end


  def should_have_expressions_with_right_delimiter(glyph)
    should "have expressions with right delimiter" do
      assert { subject.expressions.right_delim.kind_of? Ruby::Token }
    end

    should "have expressions with right delimiter with correct glyph" do
      assert { subject.expressions.right_delim.token == glyph }
    end
  end

  def should_have_expressions_with_delimiters(left, right)
    should_have_expressions_with_left_delimiter left
    should_have_expressions_with_right_delimiter right
  end
end
