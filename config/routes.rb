Rails.application.routes.draw do

  resources :discussions, only: %i(show), :defaults => {:format => :json} do
    resources :arguments, only: %i(show create)
    resources :agreements, only: %i(show create update)
  end

  resources :users, only: %i(show), :defaults => {:format => :json}

  post 'tokensignin', to: 'sessions#tokensignin', :defaults => {:format => :json}

end
