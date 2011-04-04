require "syntax_tree/ruby/nodes/abstract/composite"
require "syntax_tree/ruby/nodes/aspects/delimited"

module SyntaxTree
  module Ruby
    class Range < Node
      attr_reader :begin, :operator, :end

      def initialize(left, operator, right)
        @begin, @operator, @end = left, operator, right
      end
    end
  end
end
