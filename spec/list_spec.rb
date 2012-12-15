require 'spec_helper'

describe Project::List do
  let(:list) { Project::List.new("asdf") }

  context "when instantiated" do
    it "responds to ID" do
      list.id.should == "asdf"
    end

    it "responds to to_s" do
      list.to_s.should == "asdf"
    end
  end

  context "when not instantiated" do
    it "produces a 6 digit key as a string" do
      Project::List.new.to_s.size == 6
    end
  end

  it "has a key" do
    list.key.should == "list:asdf"
  end

  it "can retrieve items for a key" do
    Project.redis.hset(list.key, "qwer", "eggs")
    Project.redis.hset(list.key, "zxcv", "apples")
    list.items.should have(2).items
  end

  it "can create a new item" do
    Project.redis.hset(list.key, "qwer", "eggs")
    item = list.add_item("apples")
    list.items.should have(2).items

    item.should == { id: item.fetch(:id), name: "apples" }
  end

  it "can delete an item" do
    Project.redis.hset(list.key, "qwer", "eggs")
    Project.redis.hset(list.key, "zxcv", "apples")
    list.remove_item("zxcv")

    list.items.count.should == 1
    list.items.should_not include({ "zxcv" => "apples" })
  end
end