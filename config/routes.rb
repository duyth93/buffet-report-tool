Rails.application.routes.draw do
  root 'reports#new'
  devise_for :users, controllers: {sessions: 'sessions', omniauth_callbacks: 'users/omniauth_callbacks'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :reports, only: [:index, :create, :new]
  resource :chatwork_apis, only: [:create, :new]
  resource :rooms, only: [:index, :create, :new]
  get 'chatwork_apis/room_members' => 'chatwork_apis#room_members'
end
