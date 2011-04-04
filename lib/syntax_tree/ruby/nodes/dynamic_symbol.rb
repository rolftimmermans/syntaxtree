require "syntax_tree/ruby/nodes/string"

module SyntaxTree
  module Ruby
    class DynamicSymbol < String
      include Delimited

      def value
        super.to_sym
      end
    end
  end
end
