class User < ApplicationRecord
  has_secure_password
  has_secure_token

  # ActiveRecord Relationships
  has_one :driftmap, dependent: :destroy

  # Validations
  validates :email, presence: true
end