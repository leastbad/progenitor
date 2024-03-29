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
      TYPICAL_DEPTH = 3
      MAX_DEPTH = 5
      DO_NOT_WASTE_LENGTH = 40

      def inline_pairs(enum, total:, line_limit:, process_key:, value_proc: nil, depth: 0)
        return SimpleRow.new(sym_ellipsis) if too_deep?(depth, line_limit)

        row = SimpleRow.new
        item_limit = total == 0 ? 0 : line_limit_for_pair(depth, line_limit / total)

        enum.each do |(key, value), index|
          row << text_primary(", ") if index > 0

          key_inspection = inspect_nested_key(
            key,
            line_limit: item_limit, process_key: process_key, depth: depth
          )
          value_inspection = @base.inline(
            value_proc.nil? ? value : value_proc.call(key),
            line_limit: line_limit_for_pair(depth, item_limit - key_inspection.content_length), depth: depth
          )

          if row.content_length + key_inspection.content_length + value_inspection.content_length + 6 > line_limit
            row << sym_ellipsis
            break
          end
          row << key_inspection
          row << sym_arrow
          row << value_inspection
        end

        row
      end

      def multiline_pair(key, value, line_limit:, process_key:, depth: 0)
        return SimpleRow.new(sym_ellipsis) if too_deep?(depth, line_limit)

        row = SimpleRow.new(sym_bullet)
        row << inspect_nested_key(
          key,
          line_limit: line_limit - sym_bullet.content_length,
          process_key: process_key, depth: depth
        )
        row << sym_arrow
        row << @base.inline(
          value, line_limit: line_limit_for_pair(depth, line_limit - row.content_length), depth: depth
        )
      end

      def inline_values(enum, total:, line_limit:, depth: 0)
        return SimpleRow.new(sym_ellipsis) if too_deep?(depth, line_limit)

        row = SimpleRow.new
        item_limit = total == 0 ? 0 : line_limit_for_value(line_limit / total)

        enum.each do |value, index|
          row << text_primary(", ") if index > 0

          value_inspection = @base.inline(
            value, line_limit: line_limit_for_value(item_limit), depth: depth
          )

          if row.content_length + value_inspection.content_length + 2 > line_limit
            row << sym_ellipsis
            break
          end
          row << value_inspection
        end

        row
      end

      def multiline_value(value, line_limit:, depth: 0)
        return [sym_ellipsis] if too_deep?(depth, line_limit)

        row = SimpleRow.new(sym_bullet)
        row << @base.inline(
          value, line_limit: line_limit_for_value(line_limit - row.content_length), depth: depth
        )
      end

      private

      def inspect_nested_key(key, line_limit:, process_key:, depth: 0)
        if process_key
          @base.inline(key, line_limit: line_limit, depth: depth)
        else
          SimpleRow.new(text_primary(key.to_s))
        end
      end

      def too_deep?(depth, line_limit)
        return true if depth > MAX_DEPTH
        return false if line_limit > DO_NOT_WASTE_LENGTH

        depth > TYPICAL_DEPTH
      end

      def line_limit_for_pair(depth, desired)
        # The deeper structure, the less meaningful the actual data is
        [30 - depth * 5, desired].max
      end

      def line_limit_for_value(desired)
        [30, desired].max
      end
    end
  end
end
