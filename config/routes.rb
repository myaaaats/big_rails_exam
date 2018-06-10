Rails.application.routes.draw do
  resources :tweets do
    collection do
      post :confirm
    end
  end
  resources :tops
  root :to => 'tops#index'
end
