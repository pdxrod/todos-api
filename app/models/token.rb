class Token < ApplicationRecord
  belongs_to :user
  validates_presence_of :token
end
