class CreateAlbumImages < ActiveRecord::Migration
  def change
    create_table :album_images do |t|
      t.references :album
      t.references :image
    end

    add_index :album_images, :album_id
    add_index :album_images, :image_id
  end
end
