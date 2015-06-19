module Services

  # TODO This is awful. Fix, remove, nuke from orbit
  class CreateImage
    def initialize(params)
      @params = params
    end

    def perform
      @image = create_image
      if @params[:album_id] && @image.persisted?
        add_image_to_album if @params[:album_id]
      else
        @image
      end
    end

    def perform_async
      ImageUploadJob.perform_later(@params)
    end

    private

    def create_image
      @image = Image.create(remote_file_url: @params[:url], original_url: @params[:url])
    end

    def add_image_to_album
      @image.album_images.create(image: @image, album: album)
    end

    def album
      @album ||= Album.find_by_hash_id(@params[:album_id])
    end
  end
end
