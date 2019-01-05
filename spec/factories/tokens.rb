FactoryBot.define do
  factory :token do
    token { SecureRandom.uuid.gsub( '-', '' ) }
  end
end
