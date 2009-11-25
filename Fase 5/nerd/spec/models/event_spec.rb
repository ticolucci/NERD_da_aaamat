require "spec_helper"

describe Event do
  fixtures :subjects

  def valid_attributes(attributes={})
    {
      :title => "event title",
      :body => "event body",
      :date => "12/12/1212",
      :time => "12:00:22",
      :subject => subjects(:bife)
    }.merge attributes
  end

  it "should create instance" do
    Event.create! valid_attributes
  end

  it "without title shouldn't be valid" do
    event = Event.new valid_attributes(:title => "")
    event.save.should == false
  end

  it "with title that already exists shouldnt be valid" do
    Event.create! valid_attributes
    event = Event.new valid_attributes
    event.save.should == false
  end

  it "should belong to a subject" do
    event = Event.new valid_attributes
    event.save
    event.subject.should == subjects(:bife)
  end

  it "should not be able to create a event without subject" do
    event = Event.new valid_attributes(:subject => nil)
    event.save.should == false
  end
end
