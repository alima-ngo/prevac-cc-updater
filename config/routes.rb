Rails.application.routes.draw do
  get 'commcare_update/index'

  get 'commcare_update/step1'

  get 'commcare_update/step2'

  get 'commcare_update/step3'

  get 'commcare_update/step4'

  get 'commcare_update/step5'

  root 'commcare_update#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
