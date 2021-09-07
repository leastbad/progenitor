# frozen_string_literal: true

module Mole
  module Inspectors
    ##
    # A light inspector for a string. String should be escaped, and cut off.
    class StringInspector
      include ::Mole::Span::DSL

      def initialize(base)
        @base = base
        @reflection = Mole::Reflection.instance
      end

      def match?(variable)
        @reflection.call_is_a?(variable, String)
      end

      # rubocop:disable Lint/UnusedMethodArgument
      def value(variable)
        [inline(variable)]
      end

      def inline(variable)
        SimpleRow.new(
          text_string('"'),
          text_string(variable.inspect[1..-1].chomp!('"')),
          text_string('"')
        )
      end
      # rubocop:enable Lint/UnusedMethodArgument
    end
  end
end