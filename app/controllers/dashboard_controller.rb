class DashboardController < ApplicationController
  before_action :authenticate_user!

  def overview
    @sales = {"labels":["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],"series":[[0,10,30,40,30,60,50]]}
  end
end
