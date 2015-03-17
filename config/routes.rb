Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    resource :user_comments, only: [:create, :destroy]
  end  
  resource :session, only: [:new, :create, :destroy]
  resources :goals do
    resources :goal_comments, only: [:create, :destroy]
  end
end
