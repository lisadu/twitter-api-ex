Rails.application.routes.draw do
  scope '/api' do
    resources :users do
      resources :tweets do

      end
    end
  end
end
