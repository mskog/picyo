class AddOriginalUrlToImages < ActiveRecord::Migration
  def change
    add_column :images, :original_url, :string
    add_index :images, :original_url
  end
end
