class ApplicationJob < ActiveJob::Base
  include CableReady::Broadcaster
  delegate :render, to: :ApplicationController
  discard_on ActiveJob::DeserializationError
end
