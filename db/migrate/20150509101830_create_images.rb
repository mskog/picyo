class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file_id
    end
  end
end
