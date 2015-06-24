module Api
  module V1
    class AlbumImagesController < ApiController
      before_filter :load_image, only: [:show]

      def index
        album = Album.find_by_hash_id(params[:album_id])
        authorize album, :show?
        @images = album.album_images
        render json: @images, each_serializer: AlbumImageSerializer
      end

      def create
        album = Album.find_by_hash_id(params[:album_id])
        authorize album, :update?
        if params[:async]
          create_async
        else
          create_sync
        end
      end

      def show
        render json: @album_image, serializer: AlbumImageSerializer
      end

      private

      def load_image
        @album_image = AlbumImage.find(params[:id])
      end

      def create_async
        Services::CreateImage.new(create_params).perform_async
        head :ok
      end

      def create_sync
        @album_image = Services::CreateImage.new(create_params).perform
        if @album_image.persisted?
          show
        else
          render json: {}, status: 422
        end
      end

      def create_params
        params.slice(:url, :album_id)
      end
    end
  end
end
