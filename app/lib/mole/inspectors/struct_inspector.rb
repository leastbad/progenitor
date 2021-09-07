# frozen_string_literal: true

module Mole
  module Inspectors
    # TODO: This one should handle Open Struct too
    class StructInspector
      include NestedHelper
      include ::Mole::Span::DSL

      def initialize(base)
        @base = base
        @reflection = Mole::Reflection.instance
      end

      def match?(variable)
        @reflection.call_is_a?(variable, Struct)
      end

      def inline(variable)
        row = SimpleRow.new(text_dim('#<struct '))
        unless variable.class.name.nil?
          row << text_primary(variable.class.name.to_s)
          row << text_primary(' ')
        end
        row << inline_pairs(
          variable.members.each_with_index,
          total: variable.length,
          process_key: false,
          value_proc: ->(key) { variable[key] }
        )
        row << text_dim('>')
      end

      def value(variable)
        [inline(variable)]
      end
    end
  end
end