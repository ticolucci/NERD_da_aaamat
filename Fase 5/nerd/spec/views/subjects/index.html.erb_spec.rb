require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/subjects/index" do
  fixtures :subjects
  before :each do
    assigns[:subjects] = [subjects(:bife), subjects(:copa_usp)]
    render
  end

  it "should have title for the page" do
    response.should have_tag("h1", "Assuntos")
  end

  it "should render the list os subjects in <ul>" do
    response.should have_tag("ul#subjects") do
      with_tag "li", /#{subjects(:bife).title}/, :id => subjects(:bife).id
      with_tag "li", /#{subjects(:copa_usp).title}/ , :id => subjects(:copa_usp).id
    end
  end

  it "should render the link to destroy a subject" do
    response.should have_tag("a[href=?]", subject_path(subjects(:bife).id))
  end
end
