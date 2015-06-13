class ImageSerializer < ActiveModel::Serializer
  attributes :id, :url, :image_url, :file_size, :file_content_type, :width, :height

  def id
    object.hash_id
  end

  def url
    url_for(controller: '/images', action: 'show', id: object.hash_id)
  end

  def image_url
    url_for(controller: '/images', action: 'show', id: object.hash_filename)
  end
end
