# frozen_string_literal: true

class BeaconReflex < ApplicationReflex
  def youtube
    state = {"-1" => "UNSTARTED", "0" => "ENDED", "1" => "PLAYING", "2" => "PAUSED", "3" => "BUFFERING", "5" => "CUED"}
    puts "#{state[element.dataset.state]} at #{element.dataset.time}"
    morph :nothing
  end

  def tripwire(time)
    puts time
    morph :nothing
  end
end