class AlbumWithImagesSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :images, embed: :ids, embed_key: 'hash_id', embed_in_root: true

  def id
    object.hash_id
  end
end
