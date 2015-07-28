class AddTimeStampsToAlbumImages < ActiveRecord::Migration
  def change
    add_column(:album_images, :created_at, :datetime)
    add_column(:album_images, :updated_at, :datetime)
  end
end
