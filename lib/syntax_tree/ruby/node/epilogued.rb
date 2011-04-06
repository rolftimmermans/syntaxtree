module SyntaxTree
  module Ruby
    module Epilogued
      def self.included(base)
        base.append_nodes :epilogue
      end

      def initialize(assignments = {})
        assignments = { epilogue: Ruby::Epilogue.new }.merge assignments
        super
      end
    end
  end
end
