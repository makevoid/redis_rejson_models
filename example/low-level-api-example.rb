# simplest example

require "bundler"
Bundler.require :default
require_relative "../lib/redis_rejson_models"

R = Redis.new db: 12

R.flushdb

include RedisRejsonModels

RJ.configure redis: R

# RJ / key-value layer

puts RJ["foo"], "=> nil"
RJ["foo"] = "bar"
puts RJ["bar"], "=> bar"
