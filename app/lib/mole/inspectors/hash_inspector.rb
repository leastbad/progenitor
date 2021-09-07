# frozen_string_literal: true

module Mole
  module Inspectors
    class HashInspector
      include NestedHelper
      include ::Mole::Span::DSL

      def initialize(base)
        @base = base
        @reflection = Mole::Reflection.instance
      end

      def inline(variable)
        SimpleRow.new(
          text_primary('{'),
          inline_pairs(
            variable.each_with_index,
            total: variable.length, process_key: true
          ),
          text_primary('}')
        )
      end

      def value(variable)
        [inline(variable)]
      end

      def match?(variable)
        @reflection.call_is_a?(variable, Hash)
      end
    end
  end
end