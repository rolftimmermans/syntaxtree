$: << File.expand_path("../lib", File.dirname(__FILE__))
require "bundler/setup"
require "syntaxtree"

require "minitest/autorun"
require "wrong/adapters/minitest"

class MiniTest::Unit::TestCase
  class << self
    # Support declarative specification of test methods.
    def test(name)
      define_method "test_#{name.gsub(/\s+/,'_')}".to_sym, &Proc.new
    end
  end

  def parse(src)
    SyntaxTree::RubyParser.new(src).parse
  end

  def statement(src)
    parse(src).statements.first
  end

  def pos(line, col)
    SyntaxTree::Ruby::Position.new(line, col)
  end
end
