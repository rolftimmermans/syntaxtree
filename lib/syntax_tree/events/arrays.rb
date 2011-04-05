module SyntaxTree
  module Events
    module Arrays
      def on_array(argument_list)
        elements = argument_list ? argument_list.elements : []
        Ruby::Array.new elements: elements, left_delim: tokens.pop(:lbracket), right_delim: tokens.pop(:rbracket)
      end
    end
  end
end
