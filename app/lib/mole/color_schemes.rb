# frozen_string_literal: true

require "mole/color_scheme"

module Mole
  ##
  # Color scheme registry.
  class ColorSchemes
    class << self
      extend Forwardable
      def_delegators :instance, :add_color_scheme, :[], :get, :names, :each, :length

      def instance
        @instance ||= new
      end
    end

    def initialize
      @color_scheme_registry = {}
    end

    def add_color_scheme(name, color_scheme_class)
      unless color_scheme_class < Mole::ColorScheme
        raise Mole::Error, "#{color_scheme_class} must implement, and inherit from #{Mole::ColorScheme}"
      end

      @color_scheme_registry[name] = color_scheme_class
    end

    def [](name)
      @color_scheme_registry[name.to_s.strip]
    end
    alias_method :get, :[]

    def names
      @color_scheme_registry.keys.sort.dup
    end

    def length
      @color_scheme_registry.length
    end

    def each(&block)
      @color_scheme_registry.each(&block)
    end
  end
end

require "mole/color_schemes/deep_space_color_scheme"
