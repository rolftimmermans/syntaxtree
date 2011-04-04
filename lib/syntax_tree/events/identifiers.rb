module SyntaxTree
  module Events
    module Identifiers
      def on_ident(identifier)
        Ruby::Identifier.new(identifier, position)
      end
    end
  end
end
