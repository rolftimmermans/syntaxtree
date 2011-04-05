require "syntax_tree/ruby/nodes/abstract/node"

module SyntaxTree
  module Ruby
    class Association < Node
      define_nodes :key, :operator, :value
    end
  end
end
