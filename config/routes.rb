Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'users#dashboard'

  get '/upload_data', to: 'files#new', as: :file_upload

  post '/upload', to: 'files#upload', as: :upload_file
end
