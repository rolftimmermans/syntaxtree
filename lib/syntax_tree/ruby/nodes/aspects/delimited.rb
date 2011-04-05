module SyntaxTree
  module Ruby
    module Delimited
      def self.included(base)
        base.prepend_nodes :left_delim
        base.append_nodes :right_delim
      end
    end
  end
end
