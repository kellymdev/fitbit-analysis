class FilesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def upload
    file = params[:data_file]

    CreateDataFromFile.new(file.tempfile).call

    redirect_to file_upload_path
  end
end
