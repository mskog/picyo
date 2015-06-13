$redis_image_cache = Redis.new(:host => ENV['REDIS_IMAGE_CACHE_HOST'], :port => ENV['REDIS_IMAGE_CACHE_PORT'])
