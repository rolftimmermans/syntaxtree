require File.expand_path("../../test_helper", File.dirname(__FILE__))

class ToRubyIfTest < Test::Unit::TestCase
  context "to ruby" do
    should "convert if expression" do
      src = " if foo or bar\n  puts 'foo'\nend "
      assert { to_ruby(src) == src }
    end

    should "convert if expression with parentheses" do
      src = " if (foo or bar)\n  puts 'foo'\nend "
      assert { to_ruby(src) == src }
    end

    should "convert if expression with else block" do
      src = " if foo or bar\n  puts 'foo'\nelse\n  puts 'bar'\nend "
      assert { to_ruby(src) == src }
    end

    should "convert if expression with elsif block" do
      src = " if foo\n  puts 'foo'\nelsif bar\n  puts 'bar'\nelse baz\n  puts 'baz'\nend "
      assert { to_ruby(src) == src }
    end

    should "convert unless expression" do
      src = " unless foo or bar\n  puts 'foo'\nend "
      assert { to_ruby(src) == src }
    end

    should "convert unless expression with parentheses" do
      src = " unless (foo or bar)\n  puts 'foo'\nend "
      assert { to_ruby(src) == src }
    end

    should "convert unless expression with else block" do
      src = " unless foo or bar\n  puts 'foo'\nelse\n  puts 'bar'\nend "
      assert { to_ruby(src) == src }
    end

    should "convert if expression with then" do
      src = " if foo then bar else baz end "
      assert { to_ruby(src) == src }
    end

    should "convert if expression with then and parentheses" do
      src = " if( (foo)) then ((bar)) else ((baz)) end "
      assert { to_ruby(src) == src }
    end
  end
end
