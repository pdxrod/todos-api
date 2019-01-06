FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'foo@bar.com' }
    password { 'foobar' }
    token { SecureRandom.uuid.gsub( '-', '' ) }
  end
end
