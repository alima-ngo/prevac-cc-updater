Rails.application.routes.draw do

  resources :commcare_updates do
    member do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4'
      get 'step5'
    end
  end

  root 'commcare_updates#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
