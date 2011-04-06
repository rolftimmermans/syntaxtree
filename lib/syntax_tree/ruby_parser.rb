require "ripper"
require "syntax_tree/parser/token_stack"
require "syntax_tree/ruby/position"
require "syntax_tree/ruby/tokens"
require "syntax_tree/ruby/nodes"

Dir[File.dirname(__FILE__) + "/events/*.rb"].sort.each { |file| require file }

module SyntaxTree
  class RubyParser < Ripper
    class SyntaxError < RuntimeError
    end

    class << self
      def build(source, filename = nil)
        new(source, filename).parse
      end
    end

    module FailFast
      Ripper::EVENTS.each do |event|
        define_method :"on_#{event}" do |*args| raise NotImplementedError, "Cannot process #{event.inspect} at #{position}" end
      end

      def parse
        super.tap do
          raise NotImplementedError, "Could not process tokens: #{tokens.inspect}" unless tokens.empty?
        end
      end
    end

    attr_reader :source, :file

    attr_reader :tokens

    def initialize(source, file = nil, lineno = nil)
      @source, @file = source, file
      @tokens = Parser::TokenStack.new
      super
    end

    def position
      Ruby::Position.new(lineno - 1, column)
    end

    def prologue
      Ruby::Prologue.new.concat tokens.remove(:sp, :nl, :ignored_nl, :comma, :semicolon)
    end

    def epilogue
      Ruby::Epilogue.new.concat tokens.remove(:sp, :nl, :ignored_nl, :semicolon)
    end

    def on_parse_error(message)
      raise SyntaxError.new("#{file}:#{position.line + 1}: #{message}")
    end

    include FailFast

    include Events::Arguments
    include Events::Arrays
    include Events::Blocks
    include Events::Constants
    include Events::Hashes
    include Events::Identifiers
    include Events::Lexing
    include Events::Literals
    include Events::MethodCalls
    include Events::Parameters
    include Events::Statements
    include Events::Strings
    include Events::Symbols
  end
end
