Picyo::Application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :images, only: [:create, :show]
      resources :albums, only: [:create, :show, :index] do
        resources :images, only: [:index, :create, :show], controller: 'album_images'
      end
    end
  end

  get '/images/:id', controller: 'raw_images', action: :show, constraints: { id: /.*\..*/ }, as: 'raw_image'

  resources :images, only: [:show, :index]
  resources :albums, only: [:show]

  require "sidekiq/web"
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"
end