require "spec_helper"

RSpec.describe RediJsonModels do

  class Document
    extend  RediJsonModelLib
    include RediJsonModelMixin
    include Virtus.model

    attribute :id,        Integer
    attribute :name,      String
    attribute :contents,  String
  end

  before :all do
    Redis.new(db: 11).flushdb
    Redis.new(db: 12).flushdb
  end

  specify "RediJsonModel" do
    Document.new().should be_a Object
  end

  specify "model attributes" do
    doc = Document.new
    doc.should respond_to :name
    doc.should respond_to :contents

    doc.should respond_to :name=
    doc.should respond_to :contents=
  end

  specify "attributes work" do
    doc = Document.new
    doc.name = "Foo"
    doc.name.should == "Foo"
    doc.contents = "Bar"
    doc.contents.should == "Bar"
  end

  describe "CRUD" do

    specify "create" do
      Document.create name: "foo", contents: "bar"
      Document.create name: "baz", contents: "123"
    end

    specify "all" do
      all = Document.all
      all.size.should == 2

      all.first.name.should     == "foo"
      all.first.contents.should == "bar"

      all.last.name.should      == "baz"
    end

    specify "get" do
      doc = Document.get 1
      doc.id.should       == 1
      doc.name.should     == "foo"
      doc.contents.should == "bar"

      doc = Document.get 2
      doc.id.should       == 2
    end

    specify "update" do
      doc = Document.get 1
      doc.name.should == "foo"

      Document.update 1, name: "aloha"

      doc = Document.get 1
      doc.name.should == "aloha"
    end

    specify "get_attr" do
      value = Document.get_attr 1, "name"
      value.should == "aloha"
    end

    specify "save" do
      doc = Document.new name: "Foo", contents: "Bar123"
      doc.name = "Baz"
      doc.id.should be_nil

      doc.save
      doc.id.should_not be_nil

      doc = Document.get doc.id
      doc.name.should == "Baz"
    end


    specify "json" do
      data = RJ["documents:1"]
      data.should == { "contents" => "bar", "id" => 1, "name" => "aloha" }
    end

  end
end
