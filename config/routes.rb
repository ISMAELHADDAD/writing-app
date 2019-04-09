Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :discussions, only: %i(index show create destroy), :defaults => {:format => :json} do

    post 'invite', to: 'discussions#invite'
    put 'verify_invitation', to: 'discussions#verify_invitation'
    put 'fork', to: 'discussions#fork'

    resources :arguments, only: %i(index show create)
    resources :agreements, only: %i(index show create update)
    resources :avatar, only: %i() do
      put 'assign', to: 'avatars#assign'
    end
  end

  resources :users, only: %i(show), :defaults => {:format => :json}

  post 'tokensignin', to: 'sessions#tokensignin', :defaults => {:format => :json}

end
