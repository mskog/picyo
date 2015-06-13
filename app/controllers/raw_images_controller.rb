class RawImagesController < ApplicationController
  def show
    expires_in 1.year, public: true
    image = Image.find_by_hash_filename!(params[:id])
    response.headers['Content-Length'] = image.file_size.to_s
    send_data image.file.read, type: image.file_content_type, disposition: :inline
  end
end
