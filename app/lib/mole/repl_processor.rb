# frozen_string_literal: true

module Mole
  class ReplProcessor < Byebug::CommandProcessor
    def initialize(context, *args)
      super(context, *args)
      @config = Mole.config

      @session = Mole::Session.instance
      @screen_manager = @session.screen_manager
    end

    private

    def process_commands
      @session.sync(@context)
      Mole.benchmark(:redraw_screens) do
        @screen_manager.draw_screens
      end
      @session.stop
    rescue => e
      Mole.error(e)
      raise
    end
  end
end
