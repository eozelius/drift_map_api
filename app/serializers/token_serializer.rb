class TokenSerializer < ActiveModel::Serializer
  attributes :id, :email, :token
end