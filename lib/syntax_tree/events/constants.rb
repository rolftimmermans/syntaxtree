module SyntaxTree
  module Events
    module Constants
      def on_class(constant, superclass, body)
        Ruby::Class.new(
          left_delim: tokens.pop(:class),
          identifier: constant,
          operator: tokens.pop(:<),
          superclass: superclass,
          statements: body,
          right_delim: tokens.pop(:end))
      end

      def on_sclass(identifier, body)
        Ruby::MetaClass.new(
          left_delim: tokens.pop(:class),
          operator: tokens.pop(:<<),
          identifier: identifier,
          statements: body,
          right_delim: tokens.pop(:end))
      end

      def on_module(constant, body)
        Ruby::Module.new(
          left_delim: tokens.pop(:module),
          identifier: constant,
          statements: body,
          right_delim: tokens.pop(:end))
      end

      def on_const_path_ref(namespace, constant)
        namespace = Ruby::Namespace.new.push namespace if namespace.kind_of? Ruby::Constant
        namespace.push constant
      end

      def on_top_const_ref(constant)
        constant
      end
    end
  end
end
