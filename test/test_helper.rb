$: << File.expand_path("../lib", File.dirname(__FILE__))
require "bundler/setup"

require "ripper"

module SyntaxTree
  class RubyParser < Ripper
    module Debugging
      Ripper::EVENTS.each do |event|
        define_method :"on_#{event}" do |*args| raise NotImplementedError, "Cannot process :#{event}" end
      end

      def parse
        super.tap do
          raise "Token stack not empty: #{@token_stack}" unless @token_stack.empty?
          raise "Prologue stack not empty: #{@prologue_stack}" unless @prologue_stack.empty?
        end
      end
    end
    include Debugging
  end
end

require "syntaxtree"
require "syntax_tree/visitors/to_ruby"

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
