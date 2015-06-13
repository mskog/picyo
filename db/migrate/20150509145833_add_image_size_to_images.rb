class AddImageSizeToImages < ActiveRecord::Migration
  def change
    add_column :images, :file_size, :integer
  end
end
