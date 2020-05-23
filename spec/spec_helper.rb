require_relative '../lib/redis_rejson_models'

R = Redis.new db: 12
R.flushdb

include RedisRejsonModels
RJ.configure redis: R

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = [:expect, :should]
  end
end
