class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :hash_id
      t.timestamps
    end

    add_index :albums, :hash_id
  end
end
