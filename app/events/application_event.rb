# frozen_string_literal: true

class ApplicationEvent < ChronoTrigger::Event
  include CableReady::Broadcaster
  delegate :render, to: ApplicationController
end