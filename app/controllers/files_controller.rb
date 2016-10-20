class FilesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def upload
    file = params[:data_file]

    CreateDataFromFile.new(file.tempfile, current_user).call

    redirect_to dashboard_path
  end
end
