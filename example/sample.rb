# simplest example

R = Redis.new db: 12

R.flushdb

include RediJsonModels

RJ.configure redis: R

# RJ / key-value layer

puts RJ["foo"], "=> nil"
RJ["foo"] = "bar"
puts RJ["bar"], "=> bar"
