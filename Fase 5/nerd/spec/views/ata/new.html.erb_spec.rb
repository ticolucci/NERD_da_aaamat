require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/ata/new" do
  fixtures :members

  before :each do
    assigns[:atendees] = @atendees = Member.find(:all)
    render :layout => "application"
  end

  it "should have a title" do
    response.should have_tag("h1", "Gerando Ata")
  end

  it "should have a way to cancel" do
    response.should have_tag("a[href=?]", subjects_path)
  end

  it "should show all the fields" do
    response.should have_tag("form") do
      with_tag 'p' do
        with_tag 'label', 'Data'
        with_tag 'input', :id => /date/
      end
      with_tag 'table' do
        with_tag 'tr' do
          with_tag 'td' do
            with_tag 'input', :value => @atendees.first.id
            with_tag 'label', @atendees.first.name
          end
        end
      end
      with_tag 'p' do
        with_tag("input", :id => "ata_submit")
      end
    end
  end
end