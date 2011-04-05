require "syntax_tree/ruby/nodes/abstract/node"
require "syntax_tree/ruby/nodes/aspects/left_delimited"

module SyntaxTree
  module Ruby
    class Symbol < Node
      define_nodes :identifier

      include LeftDelimited

      def value
        @identifier.token.to_sym
      end
    end
  end
end
