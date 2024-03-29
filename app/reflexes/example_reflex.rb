# frozen_string_literal: true

require "mole"

class ExampleReflex < ApplicationReflex
  include ChronoTrigger::Timeline
  MYCONST = "good times"

  def send_toast
    ToastJob.perform_later(current_user, "secondary", "Hi, #{current_user.name}!")
    morph :nothing
  end

  def send_message
    cable_ready[UsersChannel].console_log(message: "Hi, #{current_user.name}!").broadcast_to(current_user)
    morph :nothing
  end

  def clock
    ChronoTrigger::Clock.send(ChronoTrigger::Clock.ticking? ? :stop : :start)
  end

  def heartbeat
    ExampleEvent.scope(current_user).after(Time.zone.now + 5.seconds).before(Time.zone.now + 21.seconds).schedule(current_user, "hello")
    morph :nothing
  end

  def clear
    chrono_trigger.clear_scope(current_user)
    morph :nothing
  end

  def threads
    puts Thread.list
    morph :nothing
  end

  def meta
    # rubocop:disable Lint/UselessAssignment
    @leastbad = current_user
    buffalo = 69
    location = [__FILE__, __LINE__]
    mole
    render plain: "Hello, #{current_user.name}!"
    morph :nothing
    # rubocop:enable Lint/UselessAssignment
  end
end
