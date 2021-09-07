# frozen_string_literal: true

module Mole
  module Inspectors
    class ArrayInspector
      include NestedHelper
      include ::Mole::Span::DSL

      def initialize(base)
        @base = base
        @reflection = Mole::Reflection.instance
      end

      def match?(variable)
        @reflection.call_is_a?(variable, Array)
      end

      def inline(variable)
        SimpleRow.new(
          text_primary('['),
          inline_values(variable.each_with_index, total: variable.length),
          text_primary(']')
        )
      end

      def value(variable)
        [inline(variable)]
      end
    end
  end
end