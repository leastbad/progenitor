class HomeController < ApplicationController
  before_action :authenticate_user!

  def cc
    render operations: cable_car.console_log(message: "Konnor!")
  end
end
