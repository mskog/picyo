module Services
  class CreateImage
    def initialize(params)
      @params = params
    end

    def perform
      create_image
      add_image_to_album if @params[:album_id]
      @image
    end

    def perform_async
      ImageUploadJob.perform_later(@params)
    end

    private

    def create_image
      @image = Image.find_or_create_by_url(@params[:url])
    end

    def add_image_to_album
      @image.albums << album unless image_included_in_album?
    end

    def image_included_in_album?
      @image.albums.include?(album)
    end

    def album
      Album.find_by_hash_id(@params[:album_id])
    end
  end
end
