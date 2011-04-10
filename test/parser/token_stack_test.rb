require File.expand_path("../test_helper", File.dirname(__FILE__))

class TokenStackTest < Test::Unit::TestCase
  def new_token(val = @val.succ!)
    Ruby::Glyph.new token: @val, position: Ruby::Position.new(1, 1)
  end

  def setup
    @val = "a"
    @stack = SyntaxTree::Parser::TokenStack.new
    @token = new_token("x")
  end

  test "token stack should have size zero initially" do
    assert { @stack.size == 0 }
  end

  test "token stack should increase in size when tokens are pushed" do
    @stack.push(:type, @token)
    assert { @stack.size == 1 }
  end

  test "token stack should pop appended token" do
    @stack.push(:type, @token)
    popped = @stack.pop
    assert { popped == @token }
  end

  test "token stack should pop appended token of given type" do
    @stack.push(:type1, @token)
    @stack.push(:type2, new_token)
    popped = @stack.pop(:type1)
    assert { popped == @token }
  end

  test "token stack should pop only one token" do
    @stack.push(:type, new_token)
    @stack.push(:type, new_token)
    @stack.pop
    assert { @stack.size == 1 }
  end

  test "token stack should pop only one token of given type" do
    @stack.push(:type, new_token)
    @stack.push(:type, new_token)
    @stack.pop(:type)
    assert { @stack.size == 1 }
  end

  test "token stack should pop nothing if given type is not available" do
    @stack.push(:foo, new_token)
    @stack.push(:bar, new_token)
    popped = @stack.pop(:type)
    assert { popped == nil }
  end

  test "token stack should pop all appended tokens of given type" do
    tokens = [new_token, new_token]
    @stack.push(:type, tokens[0])
    @stack.push(:type, tokens[1])
    popped = @stack.remove(:type)
    assert { popped == tokens }
  end

  test "token stack should pop all appended identical tokens of given type" do
    @stack.push(:type, @token)
    @stack.push(:type, @token)
    @stack.push(:another, new_token)
    popped = @stack.remove(:type)
    assert { popped == [@token, @token] }
  end

  test "token stack should pop all tokens of given type" do
    @stack.push(:type, new_token)
    @stack.push(:type, new_token)
    @stack.push(:another, new_token)
    @stack.remove(:type)
    assert { @stack.size == 1 }
  end

  test "token stack be empty if size is zero" do
    assert { @stack.empty? == true }
  end

  test "token stack not be empty if size is nonzero" do
    @stack.push(:type, new_token)
    assert { @stack.empty? == false }
  end
end
