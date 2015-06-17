class AlbumImageSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :image_height, :image_width, :image_id

  def image_url
    url_for(controller: '/images', action: 'show', id: object.image.hash_filename)
  end

  def image_id
    object.image.hash_id
  end

  def image_height
    object.image.height
  end

  def image_width
    object.image.width
  end
end
