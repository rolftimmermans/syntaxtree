require "syntax_tree/ruby/nodes/abstract/node"
require "syntax_tree/ruby/nodes/aspects/prologued"
require "syntax_tree/ruby/nodes/aspects/epilogued"

module SyntaxTree
  module Ruby
    class Token < Node
      include Prologued
      include Epilogued

      attr_reader :token, :position

      def initialize(token, position)
        @token, @position = token, position
      end
    end
  end
end
