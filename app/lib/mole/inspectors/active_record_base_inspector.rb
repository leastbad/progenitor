# frozen_string_literal: true

module Mole
  module Inspectors
    ##
    # A collection of rails-specific inspectors.
    # Why?
    # Because Rails is magic, and it is like stepping on a minefield. Rails objects
    # can trigger side-effects (like calling database queries, or even API queries).
    # And from the end-user perspective, Rails' internal variables are useless. They
    # care more about database attributes, which requires some extra steps to display
    # if I don't want to use `#inspect`.

    ##
    # Individual Active Record object is trivial. The object is a mapping from a DB
    # entity to Ruby object. It is always in the memory.
    class ActiveRecordBaseInspector
      include NestedHelper
      include ::Mole::Span::DSL

      def initialize(base)
        @base = base
        @reflection = Mole::Reflection.instance
      end

      def match?(variable)
        return false unless defined?(ActiveRecord::Base)

        @reflection.call_is_a?(variable, ActiveRecord::Base)
      end

      # rubocop:disable Style/ConditionalAssignment
      def inline(variable, line_limit:, depth: 0)
        row = SimpleRow.new(
          text_primary(@reflection.call_to_s(variable).chomp!('>')),
          text_primary(' ')
        )
        attributes = variable_attributes(variable)

        if attributes.nil?
          row << text_dim('??? failed to inspect attributes')
        else
          row << inline_pairs(
            attributes.each_with_index,
            total: attributes.length, line_limit: line_limit - row.content_length - 2,
            process_key: false, depth: depth + 1
          )
        end
        row << text_primary('>')
      end
      # rubocop:enable Style/ConditionalAssignment

      def multiline(variable, lines:, line_limit:, depth: 0)
        inline = inline(variable, line_limit: line_limit * 2)
        return [inline] if inline.content_length < line_limit

        rows = [SimpleRow.new(
          text_primary(@reflection.call_to_s(variable))
        )]

        item_count = 0
        attributes = variable_attributes(variable)

        if attributes.nil?
          rows << SimpleRow.new(text_dim('  ▸ ??? failed to inspect attributes'))
        else
          attributes.each_with_index do |(key, value), index|
            rows << multiline_pair(
              key, value, line_limit: line_limit, process_key: false, depth: depth + 1
            )
            item_count += 1
            break if index >= lines - 2
          end
          if attributes.length > item_count
            rows << SimpleRow.new(text_dim("  ▸ #{attributes.length - item_count} more..."))
          end
        end
        rows
      end

      def variable_attributes(variable)
        variable.attributes
      rescue StandardError
        nil
      end
    end
  end
end