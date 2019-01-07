require 'securerandom'

class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /signup
  # return authenticated token upon signup
  def create
    args = user_params
    user = User.create!(args)
    token_str = AuthenticateUser.new(user.email, user.password).call
    token = Token.new
    token.token = token_str
    token.save!
    user.token_id = token.id
    user.save!
    response = { message: Message.account_created, token: token_str }
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
