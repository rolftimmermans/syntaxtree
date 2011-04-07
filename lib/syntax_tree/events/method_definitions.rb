module SyntaxTree
  module Events
    module MethodDefinitions
      def on_def(identifier, parameters, body)
        Ruby::MethodDefinition.new(
          left_delim: tokens.pop(:def),
          identifier: identifier,
          parameters: parameters,
          statements: body,
          right_delim: tokens.pop(:end))
      end
    end
  end
end
