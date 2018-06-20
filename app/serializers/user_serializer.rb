class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :description
  
  has_one :driftmap
end