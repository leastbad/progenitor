# frozen_string_literal: true

require "mole/inspectors/nested_helper"
require "mole/inspectors/primitive_inspector"
require "mole/inspectors/array_inspector"
require "mole/inspectors/string_inspector"
require "mole/inspectors/hash_inspector"
require "mole/inspectors/struct_inspector"
require "mole/inspectors/object_inspector"
require "mole/inspectors/active_record_base_inspector"
require "mole/inspectors/active_record_relation_inspector"

module Mole
  module Inspectors
    # This class is inspired by Ruby's PP:
    # https://github.com/ruby/ruby/blob/master/lib/pp.rb
    class Base
      def initialize
        # Order matters here. Primitive has highest priority, object is the last fallback
        @inspectors = [
          PrimitiveInspector.new(self),
          ArrayInspector.new(self),
          StringInspector.new(self),
          HashInspector.new(self),
          StructInspector.new(self),
          ActiveRecordBaseInspector.new(self),
          ActiveRecordRelationInspector.new(self),
          ObjectInspector.new(self)
        ]
      end

      def inline(variable, line_limit:, depth: 0)
        @inspectors.each do |inspector|
          next unless inspector.match?(variable)

          row = inspector.inline(variable, line_limit: line_limit, depth: depth)
          return row unless row.nil?
        end
        SimpleRow.new(text_primary("???"))
      end

      def multiline(variable, lines:, line_limit:, depth: 0)
        @inspectors.each do |inspector|
          next unless inspector.match?(variable)

          rows = inspector.multiline(
            variable,
            lines: lines,
            line_limit: line_limit,
            depth: depth
          )
          return rows unless rows.nil?
        end
        [SimpleRow.new(text_primary("???"))]
      end
    end
  end
end
