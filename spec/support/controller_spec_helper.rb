require 'securerandom'

module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(user_id)
    token = User.find( user_id ).tokens.last
    token ? token.token : SecureRandom.uuid.gsub( '-', '' )
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id)
    token = User.find( user_id ).tokens.last
    time = Time.now.to_i - 2.hours
    token.created_at = time
    token.save!
    token.token
  end

  # return valid headers
  def valid_headers(user_id)
    {
      "Token" => token_generator(user_id),
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
