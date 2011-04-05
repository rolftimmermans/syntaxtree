require "syntax_tree/ruby/nodes/abstract/node"
require "syntax_tree/ruby/nodes/aspects/epilogued"

module SyntaxTree
  module Ruby
    class Program < Node
      attr_accessor :src, :file

      define_nodes :statements

      include Epilogued
    end
  end
end
