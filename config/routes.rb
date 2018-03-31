Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	get "admin", to: redirect("/admin/cloths")	
	namespace :admin do
  	resources :order_items
		resources :cloths
  	resources :users
    get 'login', to: 'sessions#new'
    post 'signin', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
end