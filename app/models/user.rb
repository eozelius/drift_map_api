class User < ApplicationRecord
  has_secure_password

  has_one :driftmap, dependent: :destroy
end