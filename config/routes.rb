Rails.application.routes.draw do
  root 'index#index'
  get '/index' => 'index#index'
  get '/poll' => 'index#poll'
end
