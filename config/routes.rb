Rails.application.routes.draw do
  resources :ratios
  resources :amounts
  resources :currencies do
    member do
      post 'buy', to: 'currencies#buy'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/signup' 	=> 'users#new'
  post '/signup' 	=> 'users#create'

  get '/login' 		=> 'sessions#new'
  post '/login' 	=> 'sessions#create'
  get '/logout' 	=> 'sessions#destroy'

  get '/welcome'  => 'welcome#new'
end
