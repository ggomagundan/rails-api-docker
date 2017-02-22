Sidekiq.configure_server do |config|
  #config.redis = { url: 'redis://redis.example.com:6379/12' }
  config.redis = { url: "#{ENV["redis_url"]}:#{ENV["redis_port"]}/12", network_timeout: 5 }
end

Sidekiq.configure_client do |config|
  #config.redis = { url: 'redis://redis.example.com:6379 /12' }
  config.redis = { url: "#{ENV["redis_url"]}:#{ENV["redis_port"]}/12", network_timeout: 5 }
end
