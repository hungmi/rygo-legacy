Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: 'cloths#index'
	
	resources :cloths, only: [:index, :show]

	get "admin", to: redirect("/admin/cloths")	
	namespace :admin do
		resources :cloths
  	resources :users
  end
  
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end