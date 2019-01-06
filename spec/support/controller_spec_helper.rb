require 'securerandom'

module ControllerSpecHelper

  def token_generator(user_id)
    return SecureRandom.uuid.gsub( '-', '' ) unless user_id
    User.find( user_id ).token
  end

  def expired_token_generator(user_id)
    token = User.find( user_id ).tokens.last
    token.created_at -= 2.hours

puts "\ntoken #{token.token} #{token.created_at} #{token.id}"

    token.save!
    token.token
  end

  # return valid headers
  def valid_headers(user_id)
    {
      "Token" => token_generator(user_id),
      "auth_token" => token_generator(user_id),
      "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "Token" => nil,
      "auth_token" => nil,
      "Content-Type" => "application/json"
    }
  end
end
