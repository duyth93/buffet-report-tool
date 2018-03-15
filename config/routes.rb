Rails.application.routes.draw do
  root 'application#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :reports, only: [:index, :create, :new]
  resource :chatwork_apis, only: [:index, :create, :new]
  resource :rooms, only: [:index, :create, :new]
end
