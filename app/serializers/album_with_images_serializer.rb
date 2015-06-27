class AlbumWithImagesSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :album_images, embed_in_root: true

  def id
    object.hash_id
  end
end
