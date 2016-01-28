TestMongoId::Application.routes.draw do


  devise_for :users


  resources :exercices do
    member do
      get 'select'
    end
  end

  resources :patients do
    member do
      get 'select'
    end

    collection do
      get 'selected'
    end
  end

  resources :sessions do
    member do
      get 'select'
    end

    collection do
      post 'upload'
      get 'selected'
    end
  end

  root to: "static_pages#home"


end
