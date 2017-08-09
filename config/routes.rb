Rails.application.routes.draw do
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  mount Spree::Core::Engine, at: '/'

  get '/shop' => 'spree/products#index'
  get '/about' => 'spree/custom#about'
  get '/instore-menu' => 'spree/custom#instoreMenu'
  get '/nutrition' => 'spree/custom#nutrition'
  get '/events' =>  'spree/events#show'

    scope "/admin" do
      ### Use these for initial setup
       # get "custom" => 'spree/admin/customs#new'
       # post "custom" => 'spree/admin/customs#create'
       get "events" => 'spree/admin/events#new'
       post "events" => 'spree/admin/events#create'


      ### Use these for client editiing ###
       get "custom" => 'spree/admin/customs#edit'
       patch "custom" => 'spree/admin/customs#update'
      #  get "events" => 'spree/admin/events#edit'
      #  patch "events" => 'spree/admin/events#update'


      resources :events
    end
namespace :admin do
  resources :customs, :events
end

  # get '/product-information' => 'spree/admin/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
