Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'users#dashboard'

  get '/upload_data', to: 'files#new', as: :file_upload

  post '/upload', to: 'files#upload', as: :upload_file

  get '/dashboard', to: 'users#dashboard', as: :dashboard

  get '/graphs/floor_data', to: 'graphs#floor_data', defaults: { format: 'json' }

  get '/graphs/step_data', to: 'graphs#step_data', defaults: { format: 'json' }

  get '/graphs/km_data', to: 'graphs#km_data', defaults: { format: 'json' }

  get '/graphs/calorie_data', to: 'graphs#calorie_data', defaults: { format: 'json' }
end
