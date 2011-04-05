require "syntax_tree/ruby/nodes/abstract/composite"
require "syntax_tree/ruby/nodes/aspects/delimited"

module SyntaxTree
  module Ruby
    class Range < Node
      define_nodes :begin, :operator, :end
    end
  end
end
