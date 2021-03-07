class CustomersController < ApplicationController
  before_action :authenticate_user!
end
