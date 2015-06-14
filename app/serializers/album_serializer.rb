class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :images, embed: :ids, embed_key: 'hash_id'

  def id
    object.hash_id
  end
end
