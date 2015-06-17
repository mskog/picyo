module Api
  module V1
    class AlbumImagesController < ApiController
      before_filter :load_image, only: [:show]

      def index
        @images = AlbumImage
                            .includes(:image)
                            .where(album: policy_scope(Album))
                            .where(id: params[:ids])
        render json: @images, each_serializer: AlbumImageSerializer
      end

      def create
        if params[:async]
          create_async
        else
          create_sync
        end
      end

      def show
        render json: @image, serializer: ImageSerializer
      end

      private

      def create_async
        Services::CreateImage.new(create_params).perform_async
        head :ok
      end

      def create_sync
        @image = Services::CreateImage.new(params).perform
        if @image.persisted?
          show
        else
          respond_with_failure(@image.errors)
        end
      end

      def create_params
        params.slice(:url, :album_id)
      end
    end
  end
end
