class AddFilenamesToImages < ActiveRecord::Migration
  def change
    add_column :images, :file_filename, :string
    add_column :images, :hash_filename, :string
  end
end
