Rails.application.routes.draw do
  get 'start_location/new'

  post 'start_location/create', as: 'start_location_create'

  get 'start_location/index', as: 'start_location_menu'

  get 'meet_location/new'

  post 'meet_location/create', as: 'meet_location_create'

  get 'meet_location/index', as: 'meet_location_menu'

  get 'reunite/index'

  get 'drill/index'

  get 'drill/create'

  get 'drill/show'

  get 'plan/create'

  resources :plan

  # post 'plan/create'

  resources :users

  post 'plan/plan_add', as: 'plan_add'

  get 'action_menu/index', as: 'action_menu'

  get 'welcome/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
   root :to => 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
