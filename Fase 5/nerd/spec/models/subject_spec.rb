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
end
