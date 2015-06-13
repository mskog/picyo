class AddHashIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :hash_id, :string
  end
end
