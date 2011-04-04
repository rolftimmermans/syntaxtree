require "syntax_tree/ruby/nodes/abstract/composite"

module SyntaxTree
  module Ruby
    class Epilogue < Composite
      def to_s
        elements.inject("") do |string, element|
          string += element.token
        end
      end
    end
  end
end
