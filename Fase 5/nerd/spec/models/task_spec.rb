require "spec_helper"

describe Task do
  fixtures :statuses

  def valid_attributes(attributes={})
    {
      :title => "task title",
      :body => "task body",
      :due_date => "2009-11-18",
      :status => statuses(:a_fazer)
    }.merge attributes
  end

  it "should create instance" do
    Task.create! valid_attributes
  end

  it "without title shouldnt be valid" do
    task = Task.new valid_attributes(:title => "")
    task.save.should == false
  end

  it "with title that already exists shouldnt be valid" do
    Task.create! valid_attributes
    task = Task.new valid_attributes
    task.save.should == false
  end

  it "without given status should created with a_fazer status" do
    task = Task.new valid_attributes(:status => nil)
    task.save
    task.status.status_type.should == "A Fazer"
  end
end
