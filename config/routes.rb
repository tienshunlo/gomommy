Rails.application.routes.draw do

  devise_for :users, :controllers => {:sessions => "users/sessions"}, path: "", path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  root 'doctors#index'
  
  namespace :dashboard do
    #get "posts", to: "dashboard#posts"
    #get "doctors", to: "dashboard#doctors"
    resources :posts, only: [:index]
    resources :doctors, only: [:index]
    resource :profile do
      get :edit_registration
    end
    namespace :mamabook do
      resources :posts
      resources :doctors do
        member do
          get :toggle_status
        end
      end
      #get "posts", to: "mamabook#posts"
    end
  end
  
  resources :doctors do
    get "show", to: "doctor#show"
    resources :posts do 
      resources :comments
    end
    collection do
      get :most_posts
    end
  end
  resources :posts do
    collection do
      get :posts_phase
      get :posts_issue
      get :phase_issue
    end
  end

end
