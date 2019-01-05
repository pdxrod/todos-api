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
    time = Time.now - 1.hour
    
    if token.created_at < time
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.expired_token} #{e.message}")
      )
    end

    @user ||= User.find(token.user_id)

    rescue ActiveRecord::RecordNotFound => e
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{e.message}")
      )
  end

  # check for token in `Token` header
  def http_auth_header
    if headers['Token'].present?
      return headers['Token'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
