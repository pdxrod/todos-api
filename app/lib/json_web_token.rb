class JsonWebToken
  HMAC_SECRET = TodosApi::Application.credentials.secret_key_base

  def self.decode(token)
    token
  end
end
