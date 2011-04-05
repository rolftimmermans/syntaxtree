require "syntax_tree/ruby/nodes/abstract/composite"
require "syntax_tree/ruby/nodes/aspects/delimited"

module SyntaxTree
  module Ruby
    class ArgumentList < Composite
      include Delimited
    end
  end
end
