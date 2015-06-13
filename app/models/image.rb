class Image < ActiveRecord::Base
  has_many :albums, through: :album_images
  has_many :album_images, dependent: :destroy

  attachment :file, content_type: ["image/jpeg", "image/png", "image/gif", "video/webm"]
  validates_presence_of :file

  after_create :add_metadata

  def self.find_or_create_by_url(url, &block)
    find_or_create_by(original_url: url) do |image|
      image.remote_file_url = url
    end
  end

  private

  def add_metadata
    add_hash_id
    add_dimensions
    save!
  end

  def add_hash_id
    hash = Picyo::Registry.hash_ids_images.encode(id)
    extension = self.file_filename.split('.').last
    hash_filename = "#{hash}.#{extension}"
    self.attributes= {hash_id: hash, hash_filename: hash_filename}
  end

  def add_dimensions
    self.width, self.height = FastImage.size(self.file)
  end
end
