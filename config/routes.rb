Rails.application.routes.draw do

  root 'doctors#index'
  
  namespace :dashboard do
    get "posts", to: "dashboard#posts"
    get "doctors", to: "dashboard#doctors"
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
