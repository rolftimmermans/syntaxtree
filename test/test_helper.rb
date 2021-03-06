$: << File.expand_path("../lib", File.dirname(__FILE__))
require "bundler/setup"

require "ripper"
require "syntaxtree"
require "syntax_tree/visitors/to_dot"
require "syntax_tree/visitors/to_ruby"

Defined = SyntaxTree::Events.constants.map { |c| SyntaxTree::Events.const_get(c).instance_methods }.flatten
All = Ripper::EVENTS.map { |e| :"on_#{e}" }
Missing = All - Defined
Incorrect = Defined - All
Complete = (Defined.length.to_f / All.length) * 100

puts "To be implemented: " + Missing.inspect
puts

puts "Unknown: " + Incorrect.inspect
puts

puts "#{Complete.round(2)}% complete"

require "test/unit"
require "wrong"
require "shoulda-context"
require File.expand_path("test_macros", File.dirname(__FILE__))

Wrong.config.color

class Test::Unit::TestCase
  include SyntaxTree
  include Wrong
  extend TestMacros

  def parse(source)
    RubyParser.new(source, "test.rb").parse
  end

  def expression(source)
    parse(source).expressions.first
  end

  def pos(line, col)
    Ruby::Position.new(line, col)
  end

  def to_ruby(src)
    Visitors::ToRuby.new.accept RubyParser.new(src).parse
  end
end

class Hash
  def hash_sort(&block)
    self.class[sort(&block)]
  end

  def deep_sort(&block)
    sorted = hash_sort(&block)
    sorted.each do |k, v|
      sorted[k] = v.deep_sort(&block) if v.kind_of? Hash
    end
  end
end

# FIXME: Make Node, Composite, Token and Literal abstract.
