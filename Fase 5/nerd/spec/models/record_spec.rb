require "spec_helper"

describe Record do
  fixtures :subjects

  def valid_attributes(attributes={})
    {
      :title => "record title",
      :body => "record body",
      :subject => subjects(:bife)
    }.merge attributes
  end

  it "should create instance" do
    Record.create! valid_attributes
  end

  it "without title shouldn't be valid" do
    record = Record.new valid_attributes(:title => "")
    record.save.should == false
  end

  it "with title that already exists shouldnt be valid" do
    Record.create! valid_attributes
    record = Record.new valid_attributes
    record.save.should == false
  end

  it "should belong to a subject" do
    record = Record.new valid_attributes()
    record.save
    record.subject.should == subjects(:bife)
  end

  it "should not be able to create a record without subject" do
    record = Record.new valid_attributes(:subject => nil)
    record.save.should == false
  end
end
