require 'rails_helper'

RSpec.describe Token, type: :model do
  # Association test
  # ensure User model has a 1:m relationship with the Todo model
  # Validation tests
  # ensure name, email and password_digest are present before save
  it { should validate_presence_of(:token) }
  it { should have_one(:user) }
end
