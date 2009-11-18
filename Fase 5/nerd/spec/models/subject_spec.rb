require 'spec_helper'

describe Subject do
  before(:each) do
    @valid_attributes = {
      :title => "value for title"
    }
  end

  it "should create a new instance given valid attributes" do
    subject = Subject.create!(@valid_attributes)
    subject.title.should == 'value for title'
  end

  it "should not create a new instance given invalid attributes" do
    subject = Subject.new(:title => "")
    subject.save.should == false
  end

  it "titles should be unique" do
    Subject.create!(:title => "Abate")
    subject2 = Subject.new(:title => "Abate")
    subject2.save.should == false
  end
end
