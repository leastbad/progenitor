# frozen_string_literal: true

module Mole
  class Reflection
    def self.instance
      @instance ||= new
    end

    def initialize
      @method_cache = {
        method: ::Kernel.method(:method).unbind,
        instance_method: ::Kernel.method(:instance_method).unbind,
        class: ::Kernel.method(:class).unbind,
        respond_to?: ::Kernel.method(:respond_to?).unbind,
        instance_variables: ::Kernel.method(:instance_variables).unbind,
        instance_variable_get: ::Kernel.method(:instance_variable_get).unbind,
        instance_variable_set: ::Kernel.method(:instance_variable_set).unbind,
        inspect: ::Kernel.method(:inspect).unbind,
        to_s: ::Kernel.method(:to_s).unbind,
        is_a?: ::Kernel.method(:is_a?).unbind,
        const_get: ::Kernel.method(:const_get).unbind,
        const_defined?: ::Kernel.method(:const_defined?).unbind
      }

      @instance_method_cache = {
        class: ::Kernel.instance_method(:class),
        respond_to?: ::Kernel.instance_method(:respond_to?),
        inspect: ::Kernel.instance_method(:inspect),
        to_s: ::Kernel.instance_method(:to_s)
      }
    end

    def call_is_a?(object, comparing_class)
      @method_cache[:is_a?].bind_call(object, comparing_class)
    end

    def call_method(object, method_name)
      @method_cache[:method].bind_call(object, method_name)
    end

    def call_class(object)
      if call_is_a?(object, Module)
        @method_cache[:class].bind_call(object)
      else
        @instance_method_cache[:class].bind_call(object)
      end
    end

    def call_respond_to?(object, method_name)
      if call_is_a?(object, Module)
        @method_cache[:respond_to?].bind_call(object, method_name)
      else
        @instance_method_cache[:respond_to?].bind_call(object, method_name)
      end
    end

    def call_instance_variables(object)
      @method_cache[:instance_variables].bind_call(object)
    end

    def call_instance_variable_get(object, variable)
      @method_cache[:instance_variable_get].bind_call(object, variable)
    end

    def call_instance_variable_set(object, variable, value)
      @method_cache[:instance_variable_set].bind_call(object, variable, value)
    end

    def call_inspect(object)
      if call_is_a?(object, Module)
        @method_cache[:inspect].bind_call(object)
      else
        @instance_method_cache[:inspect].bind_call(object)
      end
    end

    def call_to_s(object)
      if call_is_a?(object, Module)
        @method_cache[:to_s].bind_call(object)
      else
        @instance_method_cache[:to_s].bind_call(object)
      end
    end

    def call_const_get(object, const_name)
      @method_cache[:const_get].bind_call(object, const_name)
    end

    def call_const_defined?(object, const_name)
      @method_cache[:const_defined?].bind_call(object, const_name)
    end
  end
end

Mole::Reflection.instance
