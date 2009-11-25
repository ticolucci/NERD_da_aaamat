require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/records/show" do
  fixtures :records, :statuses, :subjects, :members

  before :each do
    assigns[:record] = @record = records(:ovos)
    assigns[:subject] = @subject = subjects(:bife)
    render :layout => "application"
  end

  it "should show the title as heading" do
    content_for(:title).should have_tag("h1", @record.title)
  end

  it "should show all attributes" do
    response.should have_tag("div#record_attributes") do
      with_tag("p", /#{@record.body}/) do
        with_tag("label", "Corpo:")
      end
      with_tag("p", /#{l(@record.created_at)}/) do
        with_tag("label", "Data de Criação:")
      end
    end
  end

  it "should be able to go to subject" do
    content_for(:bottom_links).should have_tag("a[href=?]", subject_path(@subject.id))
  end

  it "should render the link to edit a subject" do
    content_for(:top_links).should have_tag("a[href=?]", edit_subject_record_path(subjects(:bife).id, records(:ovos).id))
  end

  it "should have a link to delete the record" do
    content_for(:top_links).should have_tag("a[href=?]", subject_record_path(subjects(:bife).id, records(:ovos).id))
  end

end