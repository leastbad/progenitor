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
      def inline(variable)
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
            total: attributes.length,
            process_key: false
          )
        end
        row << text_primary('>')
      end
      # rubocop:enable Style/ConditionalAssignment

      def value(variable)
        [inline(variable)]
      end

      def variable_attributes(variable)
        variable.attributes
      rescue StandardError
        nil
      end
    end
  end
end