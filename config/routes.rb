Rails.application.routes.draw do
  mount ResqueWeb::Engine => '/resque_web'
  get 'dashboard/index'

  resources :ratios
  resources :amounts
  resources :currencies do
    member do
      post 'buy', to: 'currencies#buy'
      get 'open_modal', to: 'currencies#open_modal'

    end
    collection do
      get 'generate_chart', to:'currencies#generate_chart'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/welcome' => 'welcome#new'
  post '/welcome' => 'welcome#create'

  root to: 'dashboard#index'


end
