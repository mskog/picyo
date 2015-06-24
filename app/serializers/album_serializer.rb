class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :links

  def links
    {album_images: api_v1_album_images_url(object.id)}
  end

  def id
    object.hash_id
  end
end
