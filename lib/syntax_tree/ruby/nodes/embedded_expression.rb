require "syntax_tree/ruby/nodes/abstract/node"
require "syntax_tree/ruby/nodes/aspects/delimited"

module SyntaxTree
  module Ruby
    class EmbeddedExpression < Node
      define_nodes :statements

      include Delimited
    end
  end
end
