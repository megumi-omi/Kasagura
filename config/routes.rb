Rails.application.routes.draw do
  resources :products do
    collection do
      post :confirm
    end
  end
end
