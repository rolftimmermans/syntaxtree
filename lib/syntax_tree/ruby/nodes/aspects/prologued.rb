module SyntaxTree
  module Ruby
    module Prologued
      def self.included(base)
        base.prepend_nodes :prologue
      end

      def initialize(assignments = {})
        assignments = { prologue: Ruby::Prologue.new }.merge assignments
        super
      end
    end
  end
end
