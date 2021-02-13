class ApplicationJob < ActiveJob::Base
  include CableReady::Broadcaster
  delegate :render, to: :ApplicationController
end
