class TasksController < ApplicationController
  before_action :authenticate_user!
end
