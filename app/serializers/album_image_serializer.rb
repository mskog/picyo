class AlbumImageSerializer < ActiveModel::Serializer
  attributes :id, :album_id

  has_one :image, embed_key: :hash_id

  def album_id
    object.album.hash_id
  end
end
