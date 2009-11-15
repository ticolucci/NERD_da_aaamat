require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/subjects/new" do
  fixtures :subjects
  before :each do
    assigns[:subject] = Subject.new
    render
  end

  it "should have title for the page" do
    response.should have_tag("h1", "Novo Assunto")
  end

  it "should have a creation form" do
    response.should have_tag("form") do
      with_tag("label", "Título")
      with_tag("input", :id => "subject_title")
      with_tag("input", :id => "subject_submit")
    end
  end

end
