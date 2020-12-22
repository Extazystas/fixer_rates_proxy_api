require 'redis'

module RedisStore
  EXPIRATION_TIME_SECONDS = 1 * 24 * 60 * 60 # 1 day

  attr_reader :redis

  def redis
    @redis ||= Redis.new(host: 'localhost')
  end

  def set_cache(id, val)
    redis.setex(id, EXPIRATION_TIME_SECONDS, val)
  end

  def get_from_cache(id)
    redis.get(id)
  end
end
