Rails.application.routes.draw do
  root to: 'users#home'

  devise_for :users

  post '/save', to: 'base#save'
  get '/select', to: 'base#select'
  get '/case/:CaseNumber', to: 'cases#show', as: :show_case
  resources :cases do
    resources :comments
  end
end