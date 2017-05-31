Rails.application.routes.draw do


  namespace :api, defaults: { format: 'json' } do
    scope module: :v1 do

      resource :session, only: %i(show create destroy)
      resources :users  do
        collection do
          put :forgot_password
          put :reset_password
          get :verify_reset_token
        end
        member do
          put :update_password
        end
      end


      resources :receipt_images, only: %i(index) do
        member do
          get :preview_images
        end
      end

      resources :rsd_products, only: %i(index)

      resources :configs

      resources :imported_stores do
        member do
          post :update_imported_stores
        end

        collection do
          get 'last_import_status'
        end
      end
    end

  end

  get "*path" => "application#index"
  root to: "application#index"
end
