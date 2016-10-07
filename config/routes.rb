Rails.application.routes.draw do

  resources :commcare_updates do
    member do
      get 'step:step', action: "edit", as: "step"
      get 'new_participants_file'
      get 'new_reminders_file'
    end
  end

  root 'commcare_updates#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
