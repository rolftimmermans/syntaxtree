require "syntax_tree/ruby/nodes/abstract/node"
require "syntax_tree/ruby/nodes/aspects/prologued"
require "syntax_tree/ruby/nodes/aspects/epilogued"

module SyntaxTree
  module Ruby
    class Token < Node
      define_nodes :token

      attr_accessor :position

      include Prologued
    end
  end
end
