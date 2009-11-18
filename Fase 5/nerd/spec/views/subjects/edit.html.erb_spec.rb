require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/subjects/edit" do
  fixtures :subjects

  before :each do
    assigns[:subject] = subjects(:bife)
    render
  end

  it "should have title for the page" do
    response.should have_tag("h1", "Editando Assunto")
  end

  it "should have a creation form" do
    response.should have_tag("form") do
      with_tag("label", "Título")
      with_tag("input", :id => "subject_title")
      with_tag("input", :id => "subject_submit")
    end
  end

  it "should have a link to cancel" do
    response.should have_tag("a[href=?]", subjects_path)
  end
end