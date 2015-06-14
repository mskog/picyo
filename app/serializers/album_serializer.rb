class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name

  def id
    object.hash_id
  end
end
