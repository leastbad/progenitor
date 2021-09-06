# frozen_string_literal: true

require 'mole/screens'

module Mole
  class ScreenManager
    def initialize
      @screens = {}
      @started = false
    end

    def start
      return if started?
      @started = true
    end

    def started?
      @started == true
    end

    def stop
      return unless started?
      @started = false
    end

    def draw_screens
      start unless started?

      @screens = Mole.benchmark(:build_screens) { build_screens }

      @screens.each do |screen|
        Mole.benchmark("draw_screen #{screen.class}") do
          puts screen
        end
      end

    rescue StandardError => e
      Mole.error(e)
    end

    private

    def build_screens
      screens = Mole::Screens.names.map do |name|
        screen_class = fetch_screen(name)
        screen = screen_class.new
        Mole.benchmark("build_screen #{screen.class}") do
          screen.build
          # render_screen(screen)
        end
        screen
      end
    end

    def fetch_screen(name)
      Mole::Screens[name]
    end
  end
end