# frozen_string_literal: true

require "mole/screens"

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
        Mole.benchmark("broadcast_screen #{screen.class}") do
          # TODO CableReady
          puts screen
        end
      end
    rescue => e
      Mole.error(e)
    end

    private

    def build_screens
      Mole::Screens.names.map do |name|
        screen_class = fetch_screen(name)
        screen = screen_class.new
        Mole.benchmark("build_screen #{screen.class}") do
          screen.build
          render_screen(screen)
        end
        screen
      end
    end

    def render_screen(screen)
      Mole::ScreenRenderer.new(
        screen: screen,
        color_scheme: pick_color_scheme
      ).render
    end

    def fetch_screen(name)
      Mole::Screens[name]
    end

    def pick_color_scheme
      color_scheme_class =
        Mole::ColorSchemes[Mole.config.color_scheme] ||
        Mole::ColorSchemes[Mole::Config::DEFAULT_COLOR_SCHEME]
      color_scheme_class.new
    end
  end
end
