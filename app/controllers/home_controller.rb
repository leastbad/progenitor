class HomeController < ApplicationController
  before_action :authenticate_user!

  def cc
    # render operations: cable_car.favicon(src: "doge.jpg")
    render operations: cable_car.favicon(emoji: "💩", batch: "frank")
  end

  def test
    render layout: false
  end
end
