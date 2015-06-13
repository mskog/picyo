class Album < ActiveRecord::Base
  has_many :images, through: :album_images
  has_many :album_images, dependent: :destroy

  belongs_to :user

  after_create :add_hash_id

  private

  def add_hash_id
    hash = Picyo::Registry.hash_ids_albums.encode(id)
    self.hash_id = hash
    self.save!
  end
end
