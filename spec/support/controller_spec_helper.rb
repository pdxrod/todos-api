require 'securerandom'

module ControllerSpecHelper

  def token_generator(user_id)
    return SecureRandom.uuid.gsub( '-', '' ) unless user_id
    Token.find( User.find(user_id).token_id ).token
  end

  def expired_token_generator(user_id)
    token = Token.find( User.find(user_id).token_id )
    token.created_at -= 2.hours
    token.save!
    token.token
  end

  # return valid headers
  def valid_headers(user_id)
    {
      "token" => token_generator(user_id),
      "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "token" => nil,
      "Content-Type" => "application/json"
    }
  end
end
