module Picyo
  module Registry
    def self.hash_ids_images
      @hashids_images ||= Hashids.new(ENV['HASHIDS_IMAGES_SALT'], ENV['HASHIDS_IMAGES_LENGTH'].to_i)
    end

    def self.hash_ids_albums
      @hashids_albums ||= Hashids.new(ENV['HASHIDS_ALBUMS_SALT'], ENV['HASHIDS_ALBUMS_LENGTH'].to_i)
    end
  end
end
