require 'redis'
require 'base64'
require "refile/s3"

class RedisProxyS3Store < Refile::S3
  TTL = 3600*24

  def upload(uploadable)
    file = super
    uploadable.rewind
    $redis_image_cache.set(file.id, Base64.encode64(uploadable.read), ex: TTL)
    file
  end

  def open(id)
    data = $redis_image_cache.get(id)
    return super unless data.present?
    StringIO.new(Base64.decode64(data), 'rb')
  end
end


class RedisProxyFileStore < Refile::Backend::FileSystem
  def upload(uploadable)
    file = super
    uploadable.rewind
    $redis_image_cache.set(file.id, Base64.encode64(uploadable.read))
    file
  end

  def open(id)
    data = $redis_image_cache.get(id)
    return super unless data.present?
    StringIO.new(Base64.decode64(data), 'rb')
  end
end

aws = {
  access_key_id: ENV['AWS_S3_IMAGES_KEY'],
  secret_access_key: ENV['AWS_S3_IMAGES_SECRET'],
  region: ENV['AWS_S3_IMAGES_REGION'],
  bucket: ENV['AWS_S3_IMAGES_BUCKET'],
}


Refile.cache = Refile::Backend::FileSystem.new("uploads/cache", max_size: ENV['MAX_IMAGE_SIZE_MEGABYTES'].to_i.megabytes)

if Rails.env.test?
  Refile.store = Refile::Backend::FileSystem.new("uploads/store")
else
  Refile.store = RedisProxyS3Store.new(prefix: 'store', max_size: ENV['MAX_IMAGE_SIZE_MEGABYTES'].to_i.megabytes, **aws)
end



