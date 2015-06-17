class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :album_images, embed: :ids

  def id
    object.hash_id
  end
end
