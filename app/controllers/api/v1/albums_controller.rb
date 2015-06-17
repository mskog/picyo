module Api
  module V1
    class AlbumsController < ApiController
      before_filter :load_album, only: [:show]

      def create
        @album = Album.create(album_params)
        if @album.persisted?
          show
        else
          respond_with_failure(@album.errors)
        end
      end

      def index
        render json: policy_scope(Album), each_serializer: AlbumSerializer, root: 'albums'
      end

      def show
        render json: @album, serializer: AlbumWithImagesSerializer, root: 'album'
      end

      private

      def load_album
        @album = Album.find_by_hash_id!(params[:id])
      end

      def album_params
        params.require(:album).permit(:name).merge(user: current_user)
      end
    end
  end
end
