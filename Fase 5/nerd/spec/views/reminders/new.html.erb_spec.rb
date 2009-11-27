require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/reminders/new" do
  fixtures :tasks, :reminders

  before :each do
    assigns[:reminder] = Reminder.new
    assigns[:item] = @item = tasks(:falar_com_diretor)
    render :layout => "application"
  end

  it "should have a title" do
    response.should have_tag("h3", "Novo Lembrete")
  end

  it "should show all the fields" do
    response.should have_tag("form") do
      with_tag 'p' do
        with_tag 'label', 'Data'
        with_tag 'input', :id => /date/
      end
      with_tag 'p' do
        with_tag 'label', 'Horário'
        with_tag 'input', :id => /time/
      end
      with_tag 'p' do
        with_tag("input", :id => "reminder_submit")
      end
    end
  end

  it "should have item hidden fields" do
    response.should have_tag("input#reminder_item_id")
    response.should have_tag("input#reminder_item_type")
  end

end
