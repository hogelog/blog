Blog::Application.routes.draw do

  resources :articles, only: [:index, :show] do
    member do
      get 'hiragana'
    end
  end

  root to: 'articles#root'

  namespace :admin do
    get '/login', to: 'login#show'
    post '/login', to: 'login#login'
    get '/logout', to: 'login#logout'

    resources :articles, except: [:index] do
      collection do
        post 'preview'
      end
    end
    get '/', to: 'articles#index'

    get '/google_oauth2/callback', to: 'login#google_oauth2'
  end

end
