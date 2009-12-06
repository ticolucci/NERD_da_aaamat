require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/records/edit" do
  fixtures :records, :subjects

  before :each do
    assigns[:record] = @record = records(:ovos)
    assigns[:subject] = @subject = subjects(:bife)
    render :layout => "application"
  end

  it "should show all the fields" do
    response.should have_tag("form") do
      with_tag 'label', 'Título'
      with_tag 'input', :id => /title/
      with_tag 'label', 'Corpo'
      with_tag 'input', :id => /body/
      with_tag("input", :id => "record_submit")
    end
  end

  it "should have title" do
    content_for(:title).should have_tag("h1", "Editando Registro")
  end

  it "should have a way to cancel" do
    content_for(:bottom_links).should have_tag("a[href=?]", subject_record_path(@subject.id, @record.id))
  end

  it "should have subject hidden field" do
    response.should have_tag("input#record_subject_id")
  end

end

