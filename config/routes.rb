Rails.application.routes.draw do
  root :to => 'tops#index'
  resources :tweets do
    collection do
      post :confirm
    end
  end
  resources :tops
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
