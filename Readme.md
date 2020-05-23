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

Here's a brief walktrough of how the Instance API works

In the code that folows, we defined a `Document` model, we did that by including the `ShallowAttributes` and the `redis_rejson_models` mixins and by defining some properties/attributes.

Here's an example code that you should look at first, RedisRejsonModel's usage.

In this first code sample we have an object instantiated via the `Document` class that has 2 attribute accessors: `.name` and `.content 

We call this object `doc`, an object which not only has the properties `name` and `contents`, it has also a `.save` method.

`.save()` saves the object as a  json object in redis using the rejson indexing, here's the json object saved in redis:

```rb
{ id: 234, name: "Foo", contents: "Bar123" }
```

in JSON format:

```js
{ "id": 234, "name": "Foo", "contents": "Bar123" }
```

Here's the first sample code showing the instance api in all his glory:

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


### Query API:

RedisRejsonModels not only has the `name` has also an instance api

```rb
Document.get 123 #=> returns a single redis rejson object as a whole { id: 123, name: "Foo", contents: "..." }

Document.get_attr 123, "name" #=> "name" # this is the fastest method to read an attribute, even if your json gets big, by using `Model.get_attr` you can be sure that you've got a very quick access and retrieval of that data

Document.all #=> returns a list of hashes querying all the entries from redis [{ id: 123, name: ... }, { id: 234, name: ... }, ...]

```

### Create / Update

If you don't like setting properties and invoking `.save()` you should check out how RedisRejsonModels handles with a straightforward class-method-based api the creation and update of json records in redis. 

```rb
# Document.create attrs
doc = Document.create name: "Foo", contents: "..." 
doc.id #=> has the new auto increment id (e.g. `123`)

# Document.update id, attrs
Document.update 123, name: "Foo2" 

doc = Document.get 123 
doc.name #=> "Foo2"
```


### Model Definition:

Finally by looking at the definition we can clearly see that it's very sensible, we use ShallowAttributes attributes and RedisRejsonModels gives us all the extra method for persisting the model data.

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

treat your models as a normal ruby object (not even a PORO, just a normal object :D) and you'll go long way, maximum testability, crazy redis speeds and it's just json data, treated as a document-based database. 


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
