class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  def authenticate
    tokens = AuthenticateUser.new(auth_params[:email], auth_params[:password]).user.tokens
    token = tokens.last
    if token.nil? || token.created_at < Time.now - 1.hour
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.expired_token} #{e.message}")
      )
    end
    json_response(auth_token: token.token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
