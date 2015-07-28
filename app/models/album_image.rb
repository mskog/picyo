class AlbumImage < ActiveRecord::Base
  belongs_to :image, autosave: true
  belongs_to :album

  validates_presence_of :album
  validates_presence_of :image
end
