class TransactionsController < ApplicationController
  before_action :authenticate_user!
end
