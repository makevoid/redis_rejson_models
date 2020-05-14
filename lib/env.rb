# require 'bundler/setup'
# Bundler.require :default
require 'redis'
require 'virtus'
require 'oj'
require 'dry-inflector'
# require 'redis_rejson'
require 'rejson'

module RediJsonModels
  REDIS_DB = ENV["REDIS_DB"]

  R = Redis.new db: REDIS_DB || 0
end
