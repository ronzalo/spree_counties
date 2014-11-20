Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :api, :defaults => { :format => 'json' } do
    resources :counties, :only => [:index, :show]
  end
end
