require "syntax_tree/ruby/nodes/abstract/node"

module SyntaxTree
  module Ruby
    class Program < Node
      attr_accessor :statements

      def initialize(src, filename, statements = [])
        @src, @filename = src, filename
        @statements = statements
      end
    end
  end
end
