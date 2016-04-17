TestMongoId::Application.routes.draw do

  devise_for :users

  post 'exerciceByName'  =>  'exercices#selectByName'
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
      get 'last', as: :last
    end

    collection do
      post 'upload'
      get 'selected'
    end
  end

  root to: "static_pages#home"

end
