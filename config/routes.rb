Rails.application.routes.draw do

  resources :discussions, only: %i(show), :defaults => {:format => :json} do
    resources :arguments, only: %i(show create)
    resources :agreements, only: %i(show create update)
  end

end
