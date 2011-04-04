require "syntax_tree/ruby/nodes/abstract/node"
require "syntax_tree/ruby/nodes/aspects/delimited"

module SyntaxTree
  module Ruby
    class EmbeddedExpression < Node
      include Delimited

      attr_reader :statements
    end
  end
end
