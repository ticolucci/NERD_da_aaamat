require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/subjects/show" do
  fixtures :subjects
  
  before :each do
    assigns[:subject] = subjects(:bife)
    render
  end

  it "should render all attributes" do
    response.should have_tag("h1", subjects(:bife).title)
  end

  it "should have a link to index" do
    response.should have_tag("a[href=?]", subjects_path)
  end

  it "should have a link to edit" do
    response.should have_tag("a[href=?]", edit_subject_path(subjects(:bife).id))
  end
end