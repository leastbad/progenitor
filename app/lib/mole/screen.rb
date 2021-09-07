# frozen_string_literal: true

module Mole
  class Screen
    attr_accessor :rows, :window, :cursor, :selected

    def initialize(session: nil, config: nil)
      @session = session || Mole::Session.instance
      @config = config || Mole.config
      @window = []
      @cursor = nil
      @selected = 0
      @rows = []
    end

    def build
      raise NotImplementedError, "#{self.class} should implement this method."
    end
  end
end
