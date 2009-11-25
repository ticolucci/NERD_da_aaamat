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

end