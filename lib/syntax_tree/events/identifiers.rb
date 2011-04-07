module SyntaxTree
  module Events
    module Identifiers
      def on_ident(identifier)
        Ruby::Identifier.new(
          token: identifier,
          position: position,
          prologue: prologue)
      end

      def on_const(identifier)
        Ruby::Constant.new(
          token: identifier,
          position: position,
          prologue: prologue.push(tokens.pop(:"::")))  # FIXME
      end

      def on_ivar(identifier)
        Ruby::InstanceVariable.new(
          token: identifier,
          position: position,
          prologue: prologue)
      end

      def on_cvar(identifier)
        Ruby::ClassVariable.new(
          token: identifier,
          position: position,
          prologue: prologue)
      end

      def on_gvar(identifier)
        Ruby::GlobalVariable.new(
          token: identifier,
          position: position,
          prologue: prologue)
      end
      alias_method :on_backref, :on_gvar
    end
  end
end
