require 'securerandom'

module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(user_id)
    token = User.find( user_id ).token
    token ? token : SecureRandom.uuid.gsub( '-', '' )
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id)
    time = Time.now.to_i - 10
    JsonWebToken.encode({ user_id: user_id }, time)
  end

  # return valid headers
  def valid_headers
    {
      "Token" => token_generator(user.id),
      "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "Token" => nil,
      "Content-Type" => "application/json"
    }
  end
end
