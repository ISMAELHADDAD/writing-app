Rails.application.routes.draw do

  resources :discussions, only: %i(show), :defaults => {:format => :json} do

    post 'invite', to: 'discussions#invite'
    put 'verify_invitation', to: 'discussions#verify_invitation'

    resources :arguments, only: %i(show create)
    resources :agreements, only: %i(show create update)
    resources :avatar, only: %i() do
      put 'assign', to: 'avatars#assign'
    end
  end

  resources :users, only: %i(show), :defaults => {:format => :json}

  post 'tokensignin', to: 'sessions#tokensignin', :defaults => {:format => :json}

end
