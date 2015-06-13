class AlbumsController < ApplicationController
  def show
    @album = Album.includes(:images).find_by_hash_id(params[:id])
  end
end
