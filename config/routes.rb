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

  get '/instore' => 'spree/products#instore'
  get '/shop' => 'spree/products#index'
  get '/about' => 'spree/custom#about', as: :about
  get '/instore-menu' => 'spree/custom#instoreMenu', as: :menu
  get '/nutrition' => 'spree/custom#nutrition', as: :nutrition
  get '/events' =>  'spree/events#index', as: :events
  get '/allpay_payment' => 'spree/allpay#AioTestAll'
  get '/allpay_return' => 'spree/allpay#notify'

    scope "/admin" do

       get "/customnew" => 'spree/admin/customs#new'
       post "/customnew" => 'spree/admin/customs#create'
       get "/custom" => 'spree/admin/customs#edit', as: :edit_custom
       patch "/custom" => 'spree/admin/customs#update'

        get "/events" => 'spree/admin/events#index'
        get "/event-new" => 'spree/admin/events#new'
        post "/event-new" => 'spree/admin/events#create'
        get "/event-edit/:id" => 'spree/admin/events#edit', as: :edit_events
        patch "/event/:id" => 'spree/admin/events#update'
        get "/events/:id" => 'spree/admin/events#show'
        get "/event-delete/:id" => 'spree/admin/events#destroy'
        delete "/event-delete/:id" => 'spree/admin/events#destroy', as: :delete_event

        patch "/products/:id/variants" => 'spree/admin/products#vary_prices', as: :set_varied_prices_for_addons




    end

  # get '/product-information' => 'spree/admin/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
