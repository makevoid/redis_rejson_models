# require 'bundler/setup'
# Bundler.require :default
require 'redis'
require 'shallow_attributes'
# require 'virtus' # old dependency
require 'dry-inflector'
require 'rejson'
# require 'redis_rejson' # old dependency - less mature and featured than `rejson-rb`

module RedisRejsonModels
  REDIS_DB = ENV["REDIS_DB"]

  R = Redis.new db: REDIS_DB || 0

  class NilValue; end
end
