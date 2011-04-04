require "syntax_tree/ruby/nodes/abstract/node"

module SyntaxTree
  module Ruby
    class Composite < Node
      attr_reader :elements

      def initialize(assignments = {})
        @elements = []
        super
      end

      def push(element)
        @elements.push element
        self
      end
      alias_method :<<, :push

      def concat(array)
        @elements.concat array
        self
      end

      def method_missing(method, *args, &block)
        if @elements.respond_to? method
          @elements.send method, *args, &block
        else
          super
        end
      end
    end
  end
end
