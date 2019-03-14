class SessionsController < ApplicationController

  def tokensignin
    required_audience = JWT.decode(params[:id_token], nil, false)

    validator = GoogleIDToken::Validator.new
    jwt = validator.check(params[:id_token], required_audience[0]["aud"], false)
    p jwt
    # If token is valid, then
    if jwt

      # a. If user already registered, then return fresh session_token
      if User.where(email: jwt['email']).exists?
        u = User.find_by(email: jwt['email'])
        User.generateUniqueSessionToken(u)
        u.save!
        render :json => {"userId": u.id, "name": u.name, "sessionToken": u.session_token, "sessionTokenExpiresAt": u.session_token_expires_at}, status: :ok
        return

      # b. If user is not registered, then register and return fresh session_token
      else
        u = User.create(
          name: jwt['given_name'] + '' + jwt['family_name'],
          provider: 'google_oauth2',
          uid: jwt['sub'],
          email: jwt['email'],
          full_name: jwt['given_name'] + '_' + jwt['family_name'],
          image_url: jwt['picture']
        )
        User.generateUniqueSessionToken(u)
        if u.save!
          render :json => {"userId": u.id, "name": u.name, "sessionToken": u.session_token, "sessionTokenExpiresAt": u.session_token_expires_at}, status: :ok
          return
        end
      end

    # Error if token not valid
    else
      render :json => {"error": "validation failed"}, status: :unauthorized
    end
  end

end
