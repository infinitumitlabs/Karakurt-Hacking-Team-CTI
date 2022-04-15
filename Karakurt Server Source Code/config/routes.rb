Rails.application.routes.draw do
  root to: 'public#index'

  match "/403", to: "errors#forbidden", via: :all
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  get '/about',       to: 'public#about'
  get '/auction',     to: 'public#auction'
  get '/contact_us',  to: 'public#contact_us'
  post '/contact_us', to: 'public#message_create'

  resources :press_releases, param: :uuid
  resources :companies, param: :uuid do
    get 'files', to: 'companies#download_list_files'
    get 'download/:uuid', to: 'companies#download', as: :download_file
  end

  scope '4ZSYctVQ37UUHB5VsmNAVTNdp' do
    namespace :admin do
      get '/',                 to: 'public#index'
      get 'system',            to: 'system#index'
      get 'system/visits',     to: 'system#visits'
      post '/save_app_config', to: 'system#save_app_config'

      resources :press_releases
      resources :companies, param: :uuid do
        get 'download/:uuid',  to: 'companies#download', as: :download_file
      end
      get 'companies/id/:id',  to: 'companies#show_by_id', as: :company_by_id

      resources :users
      resources :messages do
        collection do
          delete 'all', to: 'messages#destroy_all'
        end
      end

      post 'users',  controller: :users, action: :create
      get  'signup', controller: :users, action: :new

      post 'login',  controller: :sessions, action: :create
      get  'login',  controller: :sessions, action: :new
      get  'logout', controller: :sessions, action: :destroy
    end
  end
end
