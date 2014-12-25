Rails.application.routes.draw do
  root to: 'base#select'

  post '/save', to: 'base#save'
  get '/select', to: 'base#select'
end