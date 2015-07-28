module Api
  module V1
    class ImagesController < ApiController
      before_filter :load_image, only: [:show]

      def create
        @image = Services::CreateImage.new(image_params).perform
        if @image.persisted?
          show
        else
          respond_with_failure(@image.errors)
        end
      end

      def show
        render json: @image, serializer: ImageSerializer
      end

      private

      def image_params
        params.fetch(:image, params)
      end

      def load_image
        @image = Image.find_by_hash_id!(params[:id])
      end
    end
  end
end
