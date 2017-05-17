require "bundler/setup"

require_relative '../lib/redijson_models'


include RediJsonModels

R = Redis.new db: 12

R.flushdb

include RediJsonModels

RJ.configure redis: R



RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = [:expect, :should]
  end
end
