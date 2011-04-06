module SyntaxTree
  module Ruby
    module LeftDelimited
      def self.included(base)
        base.prepend_nodes :left_delim
      end
    end
  end
end
