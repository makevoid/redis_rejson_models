require 'bundler/setup'
Bundler.require :default

module RediJsonModels
  REDIS_DB = ENV["REDIS_DB"]

  R = Redis.new db: REDIS_DB || 0
end
