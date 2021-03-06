require "syntax_tree/ruby/node"
require "syntax_tree/ruby/composite"

require "syntax_tree/ruby/node/delimited"
require "syntax_tree/ruby/node/left_delimited"

require "syntax_tree/ruby/node/epilogued"
require "syntax_tree/ruby/node/prologued"
require "syntax_tree/ruby/node/summarizable"

module SyntaxTree
  module Ruby
    class Operator < Node
      define_nodes :operator
    end



    class Alias < Node
      define_nodes :keyword, :alias, :original
    end

    class ArgumentList < Composite
      include Delimited
    end

    class Array < Composite
      include Delimited
    end

    class Association < Node
      define_nodes :key, :operator, :value
    end

    class BinaryOperator < Operator
      prepend_nodes :left
      append_nodes :right
    end

    class Block < Node
      define_nodes :parameters, :expressions

      include Delimited
    end

    class BlockArgument < Node
      define_nodes :identifier

      include LeftDelimited
    end

    class BlockParameter < Node
      define_nodes :identifier

      include LeftDelimited
    end

    class Class < Node
      define_nodes :identifier, :operator, :superclass, :expressions

      include Delimited
    end

    class DefaultParameter < Node
      define_nodes :identifier, :operator, :default
    end

    class DynamicSymbol < Node
      define_nodes :contents

      include Delimited
    end

    class ElseExpression < Node
      define_nodes :expressions

      include LeftDelimited
    end

    class EmbeddedExpression < Node
      define_nodes :expressions

      include Delimited
    end

    class EmbeddedVariable < Node
      define_nodes :identifier

      include LeftDelimited
    end

    class Epilogue < Composite
      include Summarizable
    end

    class ExpressionList < Composite
      include Delimited
    end

    class Hash < Composite
      include Delimited
    end

    class IfExpression < Node
      define_nodes :condition, :expressions, :else

      include Delimited
    end

    class KeywordCall < Node
      define_nodes :keyword, :arguments, :block
    end

    class MetaClass < Class
      define_nodes :operator, :identifier, :expressions

      include Delimited
    end

    class MethodCall < Node
      define_nodes :receiver, :operator, :identifier, :arguments, :block
    end

    class MethodDefinition < Node
      define_nodes :receiver, :operator, :identifier, :parameters, :expressions

      include Delimited
    end

    class Module < Node
      define_nodes :identifier, :expressions

      include Delimited
    end

    class Namespace < Composite
    end

    class ParameterList < Composite
      include Delimited
    end

    class Program < Node
      attr_accessor :source, :file

      define_nodes :expressions

      include Epilogued
    end

    class Prologue < Composite
      include Summarizable
    end

    class Range < Node
      define_nodes :begin, :operator, :end
    end

    class Regexp < Node
      define_nodes :contents

      include Delimited
    end

    class SplatArgument < Node
      define_nodes :identifier

      include LeftDelimited
    end

    class SplatParameter < Node
      define_nodes :identifier

      include LeftDelimited
    end

    class String < Node
      define_nodes :contents

      include Delimited
    end

    class StringContents < Composite
    end

    class Symbol < Node
      define_nodes :identifier

      include LeftDelimited

      def value
        @identifier.token.to_sym
      end
    end

    class UnaryOperator < Operator
      append_nodes :right
    end

    class UnlessExpression < Node
      define_nodes :condition, :expressions, :else

      include Delimited
    end
  end
end
