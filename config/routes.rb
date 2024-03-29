Rails.application.routes.draw do
  
  resources :posts, only: [:index, :new, :create, :show] do
    resources :likes,  only: [:create, :destroy]
    resources :stocks, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      post "markdown"
    end
  end
  
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions:      "users/sessions"
  }

  post "users/guest_sign_in"  => "users#new_guest"
  get  "users/profile_edit"   => "users#profile_edit"
  get  "users/draft"          => "users#draft"
  get  "users/favorite"       => "users#favorite"
  get  "users/:id"            => "users#show"
  
  Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
    resources :posts
  end
  
  devise_scope :posts do
    root to: "posts#index"
    get      "/search"            => "posts#search"
    post     "posts/:id/post_up"  => "posts#post_up"
  end
  
  namespace :api, format: 'json' do
    get 'presigned_url', to: 's3#presigned_url'
  end
end
