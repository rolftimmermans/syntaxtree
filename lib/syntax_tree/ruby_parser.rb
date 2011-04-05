require "ripper"
require "syntax_tree/parser/token_stack"
require "syntax_tree/ruby/position"
require "syntax_tree/ruby/nodes"

Dir[File.dirname(__FILE__) + "/events/*.rb"].sort.each { |file| require file }

module SyntaxTree
  class RubyParser < Ripper::SexpBuilder
    class ParseError < RuntimeError
    end

    class << self
      def build(src, filename = nil)
        new(src, filename).parse
      end
    end

    attr_reader :src, :file

    attr_reader :tokens

    def initialize(src, file = nil, lineno = nil)
      @src, @file = src, file
      @tokens = Parser::TokenStack.new
      @string_stack = []
      super
    end

    def position
      Ruby::Position.new(lineno.to_i, column)
    end

    def prologue
      Ruby::Prologue.new.concat tokens.remove(:sp, :nl, :ignored_nl, :comma, :semicolon)
    end

    def epilogue
      Ruby::Epilogue.new.concat tokens.remove(:sp, :nl, :ignored_nl, :semicolon)
    end

    def push_string(string)
      @string_stack << string
    end

    include Events::Arguments
    include Events::Arrays
    include Events::Hashes
    include Events::Identifiers
    include Events::Lexing
    include Events::Literals
    include Events::MethodCalls
    include Events::Statements
    include Events::Strings
    include Events::Symbols
  end
end
