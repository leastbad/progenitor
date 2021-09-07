# frozen_string_literal: true

module Mole
  module Inspectors
    ##
    # Default decorator for non-primitive data structure. It is aimed to replace default `inspect`.
    # If a variable re-implement `#inspect`, it hornors this decision, but still try to
    # parse the result.
    # Otherwise, it use `Kernel#to_s`, and try to push instance variables into the result.
    class ObjectInspector
      include NestedHelper
      include ::Mole::Span::DSL

      DEFAULT_INSPECTION_PATTERN = /#<(.*:0x[0-9a-z]+)(.*)>/i.freeze

      def initialize(base)
        @base = base
        @reflection = Mole::Reflection.instance
      end

      def match?(_variable)
        true
      end

      def inline(variable)
        native_inspect?(variable) ? decorate_native_inspection(variable) : decorate_custom_inspection(variable)
      end

      def value(variable)
        [inline(variable)]
      end

      private

      def native_inspect?(variable)
        return true unless @reflection.call_respond_to?(variable, :inspect)

        @reflection.call_method(variable, :inspect).owner == ::Kernel
      end

      def call_inspect(variable)
        variable.inspect
      rescue StandardError
        @reflection.call_to_s(variable)
      end

      def decorate_native_inspection(variable)
        raw_inspection = @reflection.call_to_s(variable)
        match = raw_inspection.match(DEFAULT_INSPECTION_PATTERN)

        if match
          instance_variables = @reflection.call_instance_variables(variable)
          row = SimpleRow.new(
            text_primary('#<'),
            text_primary(match[1])
          )
          unless instance_variables.empty?
            row << text_primary(' ')
            row << inline_pairs(
              instance_variables.each_with_index, total: instance_variables.length,
              process_key: false,
              value_proc: ->(key) { @reflection.call_instance_variable_get(variable, key) }
            )
          end
          row << text_primary('>')
        else
          SimpleRow.new(text_primary(raw_inspection))
        end
      end

      def decorate_custom_inspection(variable)
        raw_inspection = call_inspect(variable)
        match = raw_inspection.match(DEFAULT_INSPECTION_PATTERN)
        if match
          detail = match[2]
          SimpleRow.new(
            text_primary('#<'),
            text_primary(match[1]),
            text_dim(detail),
            text_primary('>')
          )
        else
          SimpleRow.new(text_primary(raw_inspection))
        end
      end
    end
  end
end