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
      with_tag "li", :id => subjects(:bife).id do
        with_tag "a", /#{subjects(:bife).title}/
      end
      with_tag "li", :id => subjects(:copa_usp).id do
        with_tag "a", /#{subjects(:copa_usp).title}/ 
      end
    end
  end

  it "should render the link to destroy a subject" do
    response.should have_tag("a[href=?]", subject_path(subjects(:bife).id))
  end

  it "should render the link to create a new subject" do
    response.should have_tag("a[href=?]", new_subject_path)
  end
end
