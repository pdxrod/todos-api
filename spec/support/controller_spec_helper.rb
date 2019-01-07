require 'securerandom'

module ControllerSpecHelper

  def token_generator(user_id)
    return SecureRandom.uuid.gsub( '-', '' ) unless user_id
    User.find(user_id).find(token_id)
  end

  def expired_token_generator(user_id)
    token = Token.find( User.find(user_id).find(token_id) )
    token.created_at -= 2.hours
    token.save!
    token.token
  end

  # return valid headers
  def valid_headers(user_id)
    {
      "auth_token" => token_generator(user_id),
      "auth_token" => token_generator(user_id),
      "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "auth_token" => nil,
      "auth_token" => nil,
      "Content-Type" => "application/json"
    }
  end
end
