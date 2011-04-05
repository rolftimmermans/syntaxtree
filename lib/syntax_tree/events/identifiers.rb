module SyntaxTree
  module Events
    module Identifiers
      def on_ident(identifier)
        Ruby::Identifier.new token: identifier, position: position, prologue: prologue
      end
    end
  end
end
