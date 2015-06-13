class ImagesController < ApplicationController
  def index
    image = Services::CreateImage.new(params).perform 
    if image.persisted?
      redirect_to raw_image_path(image.hash_filename), status: :moved_permanently
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
end
