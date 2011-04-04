module SyntaxTree
  module Events
    module Arguments
      def on_args_new
        Ruby::ArgumentList.new
      end

      def on_args_add(list, argument)
        type, token = pop_typed_token(:comma)
        argument.epilogue = Ruby::Epilogue.new elements: [token]
        list.push argument
        list
      end
    end
  end
end
