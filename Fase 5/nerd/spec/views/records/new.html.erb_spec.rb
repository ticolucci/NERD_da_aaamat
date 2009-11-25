require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/records/new" do
  fixtures :records, :subjects

  before :each do
    assigns[:record] = Record.new
    assigns[:subject] = @subject = subjects(:bife)
    render :layout => "application"
  end

  it "should show all the fields" do
    response.should have_tag("form") do
      with_tag 'p' do
        with_tag 'label', 'Título'
        with_tag 'input', :id => /title/
      end
      with_tag 'p' do
        with_tag 'label', 'Corpo'
        with_tag 'input', :id => /body/
      end
      with_tag 'p' do
        with_tag("input", :id => "record_submit")
      end
    end
  end

  it "should have title" do
    response.should have_tag("h1", "Novo Registro")
  end

  it "should have a way to cancel" do
    response.should have_tag("a[href=?]", subject_path(@subject.id))
  end

  it "should have subject hidden field" do
    response.should have_tag("input#record_subject_id")
  end

end