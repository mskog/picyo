class ImageUploadJob < ActiveJob::Base
  queue_as :images_upload

  def perform(params)
    Services::CreateImage.new(params).perform
    sleep 1 if Rails.env.production?
  end
end
