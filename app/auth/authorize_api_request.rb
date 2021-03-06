class AuthorizeApiRequest

  def initialize(headers = {})
    @headers = headers
  end

  # Service entry point - return valid user object
  def call
    {
      user: user
    }
  end

 private

  attr_reader :headers

  def user
    token = Token.find_by_token(http_auth_header)

    if token.nil?
      raise(
        ExceptionHandler::InvalidToken,
        (Message.invalid_token)
      )
    end

    time = Time.now - 1.hour
    if token.created_at < time
      raise(
        ExceptionHandler::InvalidToken,
        (Message.expired_token)
      )
    end

    User.all.each do |user|
      @user = user if token.id == user.token_id
    end
    @user

    rescue ActiveRecord::RecordNotFound => e
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{e.message}")
      )
  end

  # check for token in `token` header
  def http_auth_header
    if headers['token'].present?
      return headers['token']
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
