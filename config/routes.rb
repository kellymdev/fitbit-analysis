Rails.application.routes.draw do
  get '/upload_data', to: 'files#new', as: :file_upload

  post '/upload', to: 'files#upload', as: :upload_file
end
