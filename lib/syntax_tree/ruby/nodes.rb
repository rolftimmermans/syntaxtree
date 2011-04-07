require "syntax_tree/ruby/node"
require "syntax_tree/ruby/composite"

require "syntax_tree/ruby/node/delimited"
require "syntax_tree/ruby/node/left_delimited"

require "syntax_tree/ruby/node/epilogued"
require "syntax_tree/ruby/node/prologued"
require "syntax_tree/ruby/node/summarizable"

module SyntaxTree
  module Ruby
    class ArgumentList < Composite
      include Delimited
    end

    class Array < Composite
      include Delimited
    end

    class Association < Node
      define_nodes :key, :operator, :value
    end

    class Block < Node
      define_nodes :parameters, :statements
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
      define_nodes :identifier, :operator, :superclass, :statements
      include Delimited
    end

    class DefaultParameter < Node
      define_nodes :identifier, :operator, :default
    end

    class DynamicSymbol < Node
      define_nodes :contents
      include Delimited
    end

    class EmbeddedExpression < Node
      define_nodes :statements
      include Delimited
    end

    class Epilogue < Composite
      include Summarizable
    end

    class Hash < Composite
      include Delimited
    end

    class MetaClass < Class
      define_nodes :operator, :identifier, :statements
      include Delimited
    end

    class MethodCall < Node
      define_nodes :receiver, :operator, :identifier, :arguments, :block
    end

    class MethodDefinition < Node
      define_nodes :identifier, :parameters, :statements
      include Delimited
    end

    class Module < Node
      define_nodes :identifier, :statements
      include Delimited
    end

    class Namespace < Composite
    end

    class ParameterList < Composite
      include Delimited
    end

    class Program < Node
      attr_accessor :source, :file
      define_nodes :statements
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

    class Statements < Composite
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
  end
end
