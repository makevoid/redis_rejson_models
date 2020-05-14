require 'bundler'
Bundler.require :default

R = Redis.new db: 12
R.flushdb

include RediJsonModels
RJ.configure redis: R

class Document
  extend  RediJsonModelLib
  include RediJsonModelMixin
  include Virtus.model

  attribute :id,        Integer
  attribute :name,      String
  attribute :contents,  String

  def antani
    "#{name} -- #{contents}"
  end
end

# standard api
doc = Document.new name: "Foo", contents: "Bar123"
puts doc.name      #=> "foo"
puts doc.antani    #=> "..."
doc.name = "Baz"
doc.save
puts "saved"
puts "---\n"

doc = Document.get 1
puts doc.name      #=> "foo"
puts doc.antani    #=> "..."

# # class method based create api
# doc = Document.create name: "Foo", contents: "Bar123"
# puts doc.name      #=> "foo"
# puts doc.antani    #=> "..."
# puts "---\n"

# # class method based update api
# Document.update 1, name: "Aloha!"
# puts "updated!"
