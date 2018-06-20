class DriftmapSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng, :zoom, :user_id

  belongs_to :user
end