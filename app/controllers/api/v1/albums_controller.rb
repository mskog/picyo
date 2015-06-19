module Api
  module V1
    class AlbumsController < ApiController
      before_filter :load_album, only: [:show]

      def create
        @album = Album.create(create_params)
        if @album.persisted?
          show
        else
          respond_with_failure(@album.errors)
        end
      end

      def update
        @album = Album.find_by_hash_id(params[:id])
        @album.attributes = update_params
        @album.save!
        show
      end

      def index
        @albums = policy_scope(Album).order(id: :desc)
        render json: @albums, each_serializer: AlbumSerializer, root: 'albums'
      end

      def show
        render json: @album, serializer: AlbumWithImagesSerializer, root: 'album'
      end

      private

      def load_album
        @album = Album.find_by_hash_id!(params[:id])
      end

      def create_params
        params.require(:album).permit(:name).merge(user: current_user)
      end

      def update_params
        params.require(:album).permit(:name)
      end
    end
  end
end
