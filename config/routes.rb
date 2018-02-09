Rails.application.routes.draw do


  devise_for :users, :controllers => {:sessions => "users/sessions", :registrations => "users/registrations"}, path: "", path_names: {sign_up: 'register', sign_in: 'login', sign_out: 'logout'}
  root 'doctors#index'
  namespace :dashboard do
    resources :posts, only: [:index] do
      collection do
        get :visited_pages
        get :up_voted_items
      end
    end
    resources :doctors, only: [:index] do
      collection do
        get :up_voted_doctors
      end
    end
    resource :profile do
      resources :profile_albums
    end
    namespace :mamabook do
      resources :albums, only: [:index, :new, :create] do
        member do
          get :toggle_category
        end
      end
      resources :doctors do
        resources :doctor_albums
        member do
          get :toggle_status
        end
      end
      resources :posts
      #get "posts", to: "mamabook#posts"
    end
  end
  
  resources :users, only: [:show]

  resources :doctors do
     member do
        put "like", to: "doctors#upvote"
    end
    resources :posts do 
      resources :comments
      member do
        put "like", to: "posts#upvote"
        put "dislike", to: "posts#downvote"
      end
    end
    collection do
      get :most_posts
    end
  end
  
  resources :posts, except: [:new, :create, :edit, :update, :show, :destroy] do
    collection do
      get :posts_phase
      get :posts_issue
      get :phase_issue
    end
    
  end

end
