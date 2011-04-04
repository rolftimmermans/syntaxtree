module SyntaxTree
  module Events
    module Arrays
      def on_array(elements)
        Ruby::Array.new elements: elements, right_delim: pop_token, left_delim: pop_token
      end
    end
  end
end
