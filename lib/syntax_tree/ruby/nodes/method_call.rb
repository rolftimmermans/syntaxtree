require "syntax_tree/ruby/nodes/abstract/node"

module SyntaxTree
  module Ruby
    class MethodCall < Node
      define_nodes :receiver, :operator, :identifier, :arguments, :block
    end
  end
end
