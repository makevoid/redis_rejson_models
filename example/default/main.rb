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
doc.save
puts "saved"
puts "---\n"

# # class method based create api
# doc = Document.create name: "Foo", contents: "Bar123"
# puts doc.name      #=> "foo"
# puts doc.antani    #=> "..."
# puts "---\n"

Document.update 1, name: "Aloha!"
puts "updated!"

doc = Document.get 1
puts doc.name      #=> "foo"
puts doc.antani    #=> "..."
