class UploadedFilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @uploaded_file = current_user.uploaded_files.new
    @uploaded_files = current_user.uploaded_files.order(:id)
    @file_slots = current_user.file_slots
  end
end
