# frozen_string_literal: true

module Mole
  module Inspectors
    ##
    # Helper for nested data structure. Support:
    # - Collection of values
    # - Collection of key-value pairs
    # - Individual value
    # - Individual pair
    module NestedHelper
      def inline_pairs(enum, total:, process_key:, value_proc: nil)
        row = SimpleRow.new

        enum.each do |(k, v), index|
          row << text_primary(', ') if index > 0

          key_inspection = inspect_nested_key(k, process_key: process_key)
          value_inspection = @base.inline(value_proc.nil? ? v : value_proc.call(k))

          row << key_inspection
          row << sym_arrow
          row << value_inspection
        end

        row
      end

      def multiline_pair(k, v, process_key:)
        row = SimpleRow.new(sym_bullet)
        row << inspect_nested_key(k, process_key: process_key)
        row << sym_arrow
        row << @base.inline(v)
      end

      def inline_values(enum, total:)
        row = SimpleRow.new

        enum.each do |v, i|
          row << text_primary(', ') if i > 0
          row << @base.inline(v)
        end

        row
      end

      def multiline_value(value)
        row = SimpleRow.new(sym_bullet)
        row << @base.inline(value)
      end

      private

      def inspect_nested_key(k, process_key:)
        process_key ? @base.inline(k) : SimpleRow.new(text_primary(k.to_s))
      end
    end
  end
end