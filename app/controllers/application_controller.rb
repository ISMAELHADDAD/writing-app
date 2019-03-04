class ApplicationController < ActionController::API
  include ExceptionHandler

  helper_method :current_user

  def authenticate
    render :json => {message: "session_token expired or doesn't exists"},
      status: :unauthorized unless sessionToken_valid?
  end

  def current_user
    @current_user = User.find_by(
      session_token: request.headers["Authorization"]) if request.headers["Authorization"]
  end

  def sessionToken_valid?
    @current_user = current_user

    if @current_user && DateTime.now() < @current_user.session_token_expires_at
      return true
    end
    return false
  end

end
