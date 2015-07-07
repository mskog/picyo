class AlbumImageSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :image_height, :image_width, :image_id, :image_file_content_type, :album_id

  def album_id
    object.album.hash_id
  end

  def image_url
    raw_image_url(object.image.hash_filename)
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

  def image_file_content_type
    object.image.file_content_type
  end
end
