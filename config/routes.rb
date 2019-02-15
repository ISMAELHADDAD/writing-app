Rails.application.routes.draw do

  resources :discussions, :defaults => {:format => :json}

end
