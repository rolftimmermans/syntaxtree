module SyntaxTree
  module Events
    module Arrays
      def on_array(argument_list)
        Ruby::Array.new(
          left_delim: tokens.pop(:lbracket),
          elements: argument_list ? argument_list.elements : [],
          right_delim: tokens.pop(:rbracket))
      end
    end
  end
end
