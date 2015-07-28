module Api
  module V1
    class AlbumImagesController < ApiController
      before_filter :load_image, only: [:show]

      def index
        album = Album.eager_load(album_images: [:image]).find_by_hash_id(params[:album_id])
        authorize album, :show?
        if params[:page]
          index_paginated(album)
        else
          index_full(album)
        end
      end

      def create
        authorize album, :update?
        if params[:async]
          create_async
        else
          create_sync
        end
      end

      def show
        album = Album.find(@album_image.album_id)
        authorize album, :show?
        render json: @album_image, serializer: AlbumImageSerializer
      end

      def destroy
        @album_image = AlbumImage.find(params[:id])
        album = Album.find(@album_image.album_id)
        authorize album, :update?
        @album_image.destroy
        show
      end

      private

      def album_id
        album_image_params[:album_id]
      end

      def album_image_params
        params.fetch(:album_image, params)
      end

      def image_params
        album_image_params.fetch(:image, album_image_params)
      end

      def index_full(album)
        @images = album.album_images
        render json: @images, each_serializer: AlbumImageSerializer
      end

      def index_paginated(album)
        per_page = params[:per_page].presence || 25
        @images = album.album_images.page(params[:page]).per(per_page)
        render json: @images, each_serializer: AlbumImageSerializer, meta: {total_pages: @images.num_pages}
      end

      def load_image
        @album_image = AlbumImage.find(params[:id])
      end

      def create_async
        Services::CreateImage.new(create_params).perform_async
        head :ok
      end

      def create_sync
        if image_params[:url]
          image = Image.from_url(image_params[:url])
        elsif image_params[:image_id]
          image = Image.find_by_hash_id(image_params[:image_id])
        end
        @album_image = album.add_image image
        @album_image.save
        if @album_image.persisted?
          show
        else
          render json: {}, status: 422
        end
      end

      def album
        @album ||= Album.find_by_hash_id(album_id)
      end

      def create_params
        params.slice(:url, :album_id)
      end
    end
  end
end
