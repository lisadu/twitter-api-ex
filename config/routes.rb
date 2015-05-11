Rails.application.routes.draw do
  scope '/api', :defaults => { :format => :json } do
    resources :users, only: [:show] do
      resources :tweets do

      end
    end
  end
end
