Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL']}

  Sidekiq::Middleware::Server::RetryJobs.send(:remove_const, :DEFAULT_MAX_RETRY_ATTEMPTS)
  Sidekiq::Middleware::Server::RetryJobs::DEFAULT_MAX_RETRY_ATTEMPTS = 5
end
