require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/events/show" do
  fixtures :events, :subjects

  before :each do
    assigns[:event] = @event = events(:abate)
    assigns[:subject] = @subject = subjects(:bife)
    render :layout => "application"
  end

  it "should show the title as heading" do
    content_for(:title).should have_tag("h1", @event.title)
  end

  it "should show all attributes" do
    response.should have_tag("table#event_body") do
      with_tag("td", /#{@event.body}/)
    end
    response.should have_tag("table#date_and_time") do
      with_tag("td", /#{l(@event.date)}/)
      with_tag("td", /#{l(@event.time, :format => :short)}/)
    end
    response.should have_tag("div#created_at", /#{l(@event.created_at)}/)
  end

  it "should be able to go to subject" do
    content_for(:bottom_links).should have_tag("a[href=?]", subject_path(@subject.id))
  end

  it "should render the link to edit a subject" do
    content_for(:top_links).should have_tag("a[href=?]", edit_subject_event_path(subjects(:bife).id, events(:abate).id))
  end

  it "should have a link to delete the event" do
    content_for(:top_links).should have_tag("a[href=?]", subject_event_path(subjects(:bife).id, events(:abate).id))
  end

end

