class AddIndexesToImages < ActiveRecord::Migration
  def change
    add_index :images, :file_id, unique: true
    add_index :images, :hash_id, unique: true
    add_index :images, :hash_filename, unique: true
  end
end
