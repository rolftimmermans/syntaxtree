require "ripper"
require "syntax_tree/ruby/position"
require "syntax_tree/ruby/nodes"

Dir[File.dirname(__FILE__) + "/events/*.rb"].sort.each { |file| require file }

module SyntaxTree
  class RubyParser < Ripper
    class ParseError < RuntimeError
    end

    class << self
      def build(src, filename = nil)
        new(src, filename).parse
      end
    end

    attr_reader :src, :file

    def initialize(src, file = nil, lineno = nil)
      @src, @file = src, file
      @token_stack = []
      @prologue_stack = []
      @string_stack = []
      super
    end

    def position
      Ruby::Position.new(lineno.to_i, column)
    end

    def push_token(type, token)
      @token_stack << [type, token]
    end

    def pop_token
      @token_stack.pop[1] rescue nil
    end

    def pop_typed_token(*types)
      tuple = @token_stack.reverse_each.find { |type, token| types.include? type }
      @token_stack.delete(tuple)
    end

    def push_prologue(token)
      @prologue_stack << token
    end

    def push_string(string)
      @string_stack << string
    end

    def collect_string
      string = @string_stack
      @string_stack = []
      string
    end

    def collect_prologue
      prologue = Ruby::Prologue.new.concat @prologue_stack
      @prologue_stack = []
      prologue
    end

    include Events::Arguments
    include Events::Arrays
    include Events::Identifiers
    include Events::Lexing
    include Events::Literals
    include Events::Statements
    include Events::Strings
    include Events::Symbols
  end
end
