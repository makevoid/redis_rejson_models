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

Benchmark.ips do |x|
  x.config(:time => 10, :warmup => 2)
  x.report("create") do
    Document.create name: "foo", contents: "bar"
  end
  x.report("get") do
    Document.get 1
  end
  x.report("save") do
    doc = Document.new name: "foo", contents: "bar"
    doc.name = "baz"
    doc.save
  end
end
