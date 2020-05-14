# require 'bundler/setup'
# Bundler.require :default
require 'redis'
require 'virtus'
require 'dry-inflector'
require 'rejson'
# require 'redis_rejson' # a little bit faster but has less features than the above

module RediJsonModels
  REDIS_DB = ENV["REDIS_DB"]

  R = Redis.new db: REDIS_DB || 0

  class NilValue; end
end
