# RediJsonModels

RediJSONModels

Document-like ORM based on Redis key value store - uses Redis Re-JSON for full json manipulation 

Note that Re-JSON is a redis module, you need Redis v4+ and that model enabled for this to work (otherwise if you don't need Re-JSON you can also configure this repo to run only as key value but you will lose the full json manipulations that leads to faster partial updates on nested data structures, the ability to manipulate counters, etc..)

Re-JSON requires Redis v4+

### DB API

```ruby
Model.get 1 #=> returns an object instance (gets it from ethereum)

Model.all #=> returns an array of Model object instances

Model.create({}) #=> creates an entry in ethereum

Model.update(1, {}) #=> updates a record in ethereum
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
doc.name      #=> "foo"
doc.antani    #=> "..."

doc.save      # TODO: to implement - for now use create/update classmethods

doc.update(name: "bar", contents: "...") # current api

doc1 = Document.get 1
doc == doc1 # true # TODO: equality
```
---

Enjoy!

@makevoid
