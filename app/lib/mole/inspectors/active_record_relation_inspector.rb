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
    # When creating an active record relation, Rails won't trigger any SQL query, until
    # to_ary events. It is required to check for records loaded before recursively display
    # its children. Hint if the relation is not loaded yet.
    class ActiveRecordRelationInspector
      include NestedHelper
      include ::Mole::Span::DSL

      def initialize(base)
        @base = base
        @reflection = Mole::Reflection.instance
      end

      def match?(variable)
        return false unless defined?(ActiveRecord::Relation)

        @reflection.call_class(variable) < ActiveRecord::Relation
      rescue StandardError
        false
      end

      def inline(variable)
        if loaded?(variable)
          row = SimpleRow.new(text_primary(@reflection.call_to_s(variable).chomp('>')))
          row << text_primary(' ') if variable.length >= 1
          row << inline_values(variable.each_with_index, total: variable.length)
          row << text_primary('>')
          row << text_primary(' (empty)') if variable.length <= 0
          row
        else
          relation_summary(variable)
        end
      end

      def value(variable)
        [inline(variable)]
      end

      private

      def relation_summary(variable)
        overview = @reflection.call_to_s(variable).chomp('>')
        width = overview.length + 1 + 12
        row = SimpleRow.new(text_primary(overview))
        if @reflection.call_respond_to?(variable, :to_sql)
          row << text_dim(' ')
          row << text_dim(variable_sql(variable))
        end
        row << text_primary('>')
        row << text_dim(' (not loaded)')
        row
      end

      def loaded?(variable)
        variable.respond_to?(:loaded?) && variable.loaded?
      rescue StandardError
        false
      end

      def variable_sql(variable)
        variable.to_sql.inspect
      rescue StandardError
        'failed to inspect active relation\'s SQL'
      end
    end
  end
end