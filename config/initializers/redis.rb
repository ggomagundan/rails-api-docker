require 'redis'
require 'redis/objects'

=begin
REDIS_CONFIG = YAML.load( File.open( Rails.root.join("config/redis.yml") ) ).symbolize_keys
dflt = REDIS_CONFIG[:default].symbolize_keys
cnfg = dflt.merge(REDIS_CONFIG[Rails.env.to_sym].symbolize_keys) if REDIS_CONFIG[Rails.env.to_sym]

$redis = Redis.new(cnfg)
#Redis::Objects.redis = $redis
#$redis_ns = Redis::Namespace.new(cnfg[:namespace], :redis => $redis) if cnfg[:namespace]
#
# To clear out the db before each test
$redis.flushdb if Rails.env = "test"
=end

$redis = Redis::Namespace.new("redis_namespace", redis: Redis.new(url: ENV["redis_url"], password: "redis_pwd"))
