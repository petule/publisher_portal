
require 'sidekiq/api'
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/1' }
  config.logger.level = Logger::DEBUG
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/1' }
end
