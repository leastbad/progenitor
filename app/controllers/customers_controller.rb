class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @filter = CustomerFilter.new
    @pagy, @customers = pagy(@filter.scope)
  end
end
