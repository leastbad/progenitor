# frozen_string_literal: true

require 'chrono_trigger/event'

class ApplicationEvent < ChronoTrigger::Event
  include CableReady::Broadcaster
  delegate :render, to: ApplicationController
end