Rails.application.routes.draw do
  root 'products#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'users/general_guest_sign_in', to: 'users/sessions#general_guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end

  resources :products, except: [:show, :edit] do
    collection do
      post :confirm
      post :edit_found
      post :edit_confirm
      patch :modify
    end
  end

  resources :frames, except: [:show, :edit] do
    collection do
      post :confirm
      post :edit_confirm
      patch :modify
    end
  end

end
