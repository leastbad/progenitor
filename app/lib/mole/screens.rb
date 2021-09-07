# frozen_string_literal: true

require "mole/screen"

module Mole
  class Screens
    class << self
      extend Forwardable
      def_delegators :instance, :add_screen, :[], :get, :names

      def instance
        @instance ||= new
      end
    end

    def initialize
      @screen_registry = {}
    end

    def add_screen(name, screen_class)
      unless screen_class < Mole::Screen
        raise Mole::Error, "#{screen_class} must implement, and inherit from #{Mole::Screen}"
      end

      @screen_registry[name.to_s] = screen_class
    end

    def [](name)
      @screen_registry[name.to_s]
    end
    alias_method :get, :[]

    def names
      @screen_registry.keys.sort.dup
    end
  end
end

# require 'mole/screens/source_screen'
# require 'mole/screens/backtrace_screen'
# require 'mole/screens/threads_screen'
require "mole/screens/variables_screen"
