class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :description, :token
  has_one :driftmap
  link(:self) { user_url(object) }
end