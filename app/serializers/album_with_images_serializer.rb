class AlbumWithImagesSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_ids

  has_many :images, embed_in_root: true

  def image_ids
    images.map(&:hash_id)
  end

  def id
    object.hash_id
  end
end
