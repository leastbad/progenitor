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
      puts "let's draw"
      @screens = Mole.benchmark(:build_screens) { build_screens }

      puts "hrmmmm"

      @screens.each do |screen|
        Mole.benchmark("draw_screen #{screen.class}") do
          puts "I said BIIIIIIIIIIIIIIIIIIIICH"
          puts screen.inspect
          # Mole::ScreenDrawer.new(screen: screen).draw
        end
      end

    rescue StandardError => e
      Mole.error(e)
    end

    private

    def build_screens
      puts "let's build"
      screens = Mole::Screens.names.map do |name|
        puts "it's #{name} time"
        screen_class = fetch_screen(name)
        screen = screen_class.new
        Mole.benchmark("build_screen #{screen.class}") do
          screen.build
          # render_screen(screen)
          puts "Mr. Bean"
        end
        screen
      end
    end

    def fetch_screen(name)
      Mole::Screens[name]
    end
  end
end