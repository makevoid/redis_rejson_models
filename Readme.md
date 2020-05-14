# RediJsonModels

Document-like ORM based on Redis key value store - uses Redis Re-JSON for full json manipulation

### Requirements

- Redis (v4+)
- Re-JSON module installed

### DB API

```ruby
Model.get 1 #=> returns an object instance (gets it from redis)

Model.all #=> returns an array of Model object instances

Model.create({}) #=> creates an entry in redis

Model.update(1, {}) #=> updates a record in redis
```

### Model Definition and Instance API by Virtus

#### Definition:

```ruby
class Document
  extend  RediJsonModelLib
  include RediJsonModelMixin
  include Virtus.model

  attribute :id,        Integer
  attribute :name,      String
  attribute :contents,  String

  def antani
    # "..."
  end
end
```

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

### Run local Redis (+ Re-JSON module) locally via Docker:

in this repo run:

```
docker-compose up
```

Which use the docker-compose.yml to start your redis.


### Run specs

(you need to run a local redis + rejson service - explained above)

Run:

```
rake spec
```


---

Enjoy!

@makevoid