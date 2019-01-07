require 'securerandom'

class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /signup
  # return authenticated token upon signup
  def create
    args = user_params
    user = User.create!(args)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    token = Token.new
    token.token = auth_token
    token.user_id = user.id
    user.save!
    token.save!
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
