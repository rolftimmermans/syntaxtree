require "forwardable"
require "syntax_tree/ruby/node"

module SyntaxTree
  module Ruby
    class Composite < Node
      define_nodes :elements

      include Enumerable

      extend Forwardable
      delegate [:each, :last, :size, :empty?] => :elements

      def initialize(assignments = {})
        @elements = []
        super
      end

      def push(element)
        @elements.push element if element
        self
      end

      def concat(array)
        @elements.concat array if array
        self
      end
    end
  end
end
