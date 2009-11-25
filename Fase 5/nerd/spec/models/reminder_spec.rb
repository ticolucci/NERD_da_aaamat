require "spec_helper"

describe Reminder do
  fixtures :tasks

  def valid_attributes(attributes={})
    {
      :date => "12/12/1212",
      :time => "12:00:22",
      :item_id => tasks(:falar_com_diretor).id,
      :item_type => "Tasks"
    }.merge attributes
  end

  it "should create an instance" do
    Reminder.create! valid_attributes
  end

  it "shoulnt be created given invalid attributes" do
    reminder = Reminder.new valid_attributes(:date => "")
    reminder.save.should == false
  end

  it "should set a default time" do
    reminder = Reminder.create! valid_attributes(:time => "")
    reminder.time.should == "12:00:00"
  end

  it "shouldnt be created if a reminder with same attributes already exists" do
    Reminder.create! valid_attributes
    reminder = Reminder.new valid_attributes
    reminder.save.should == false
  end

  it "should be associated to a item" do
    reminder = Reminder.new valid_attributes(:item_id => "")
    reminder.save.should == false
  end
end