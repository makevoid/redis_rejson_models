# RedisRejsonModels

Document-like ORM based on Redis key value store - uses Redis Re-JSON for full json manipulation

### Install

Add to your gemfile:

```rb
gem 'redis_rejson_models', '~> 0.9.5'
```

Or without bundler, run in your shell:

    gem i redis_rejson_models


### Requirements

- Redis (v4+)
- Re-JSON module installed


### Instance API:

```ruby
doc = Document.new name: "Foo", contents: "Bar123"
puts doc.name      #=> "foo"
puts doc.antani    #=> "..."
doc.save # saves the record, gives an auto increment id (example: 1)

doc = Document.get doc.id
puts doc.name      #=> "foo"
puts doc.antani    #=> "..."
```

Note: We use the `shallow_attributes` gem (already required by `redis_rejson_models` that provides the main ORM Model-like familiar ruby API that most ruby ORMs have / used to have)

#### Definition:

```ruby
class Document
  extend  RedisRejsonModelLib
  include RedisRejsonModelMixin
  include ShallowAttributes

  attribute :id,        Integer
  attribute :name,      String
  attribute :contents,  String

  def antani
    "hi #{name}, what do you think about #{contents} ?"
  end
end
```


### Run local Redis (+ Re-JSON module) locally via Docker:

in this repo run:

```
docker-compose up
```

Which use the docker-compose.yml to start your redis.


### Set up your Redis and RJSON

```rb
# sample environment setup
require 'bundler'
Bundler.require :default

# setup redis
R = Redis.new

# load and configure redis with rejson models
include RedisRejsonModels
RJ.configure redis: R

class Document
  # ...
end
```


### Run specs

(you need to run a local redis + rejson service - explained above)

Run:

```
rake spec
```


---

Enjoy!

@makevoid
