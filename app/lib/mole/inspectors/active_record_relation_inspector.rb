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
      rescue
        false
      end

      def inline(variable, line_limit:, depth: 0)
        if loaded?(variable)
          row = SimpleRow.new(text_primary(@reflection.call_to_s(variable).chomp(">")))
          row << text_primary(" ") if variable.length >= 1
          row << inline_values(
            variable.each_with_index,
            total: variable.length, line_limit: line_limit - row.content_length - 2,
            depth: depth + 1
          )
          row << text_primary(">")
          row << text_primary(" (empty)") if variable.length <= 0
          row
        else
          relation_summary(variable, line_limit: line_limit)
        end
      end

      def multiline(variable, lines:, line_limit:, depth: 0)
        inline = inline(variable, line_limit: line_limit * 2)
        if inline.content_length < line_limit
          [inline]
        elsif !loaded?(variable)
          [relation_summary(variable, line_limit: line_limit * 2)]
        else
          rows = [SimpleRow.new(text_primary(@reflection.call_to_s(variable)))]

          item_count = 0
          variable.each_with_index do |value, index|
            rows << multiline_value(value, line_limit: line_limit, depth: depth + 1)

            item_count += 1
            break if index >= lines - 2
          end
          if variable.length > item_count
            rows << SimpleRow.new(text_dim("  ▸ #{variable.length - item_count} more..."))
          end
          rows
        end
      end

      private

      def relation_summary(variable, line_limit:)
        overview = @reflection.call_to_s(variable).chomp(">")
        width = overview.length + 1 + 12
        row = SimpleRow.new(text_primary(overview))
        if @reflection.call_respond_to?(variable, :to_sql) && width < line_limit
          detail = variable_sql(variable)
          detail = detail[0..line_limit - width - 2] + "…" if width + detail.length < line_limit
          row << text_dim(" ")
          row << text_dim(detail)
        end
        row << text_primary(">")
        row << text_dim(" (not loaded)")
        row
      end

      def loaded?(variable)
        variable.respond_to?(:loaded?) && variable.loaded?
      rescue
        false
      end

      def variable_sql(variable)
        variable.to_sql.inspect
      rescue
        "failed to inspect active relation's SQL"
      end
    end
  end
end
