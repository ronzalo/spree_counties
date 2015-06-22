Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :api, :defaults => { :format => 'json' } do
    resources :counties, :only => [:index, :show]
  end

  namespace :admin do
    resources :counties
    resource :states do
      resources :counties
    end
  end
end
