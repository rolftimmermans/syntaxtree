module SyntaxTree
  module Ruby
    module Summarizable
      def to_s
        elements.inject("") do |string, element|
          string += element.token
        end
      end
    end
  end
end
