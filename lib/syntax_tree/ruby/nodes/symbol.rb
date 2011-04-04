require "syntax_tree/ruby/nodes/abstract/node"
require "syntax_tree/ruby/nodes/aspects/left_delimited"

module SyntaxTree
  module Ruby
    class Symbol < Node
      include LeftDelimited

      attr_reader :identifier

      def initialize(identifier)
        @identifier = identifier
      end

      def value
        @identifier.token.to_sym
      end
    end
  end
end
