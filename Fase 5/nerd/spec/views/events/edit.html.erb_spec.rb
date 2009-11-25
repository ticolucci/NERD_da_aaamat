require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/events/edit" do
  fixtures :events, :subjects

  before :each do
    assigns[:event] = @event = events(:abate)
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
        with_tag 'label', 'Horário'
        with_tag 'input', :id => /#time/
      end
      with_tag 'p' do
        with_tag("input", :id => "event_submit")
      end
    end
  end

  it "should have title" do
    content_for(:title).should have_tag("h1", "Editando Evento")
  end

  it "should have a way to cancel" do
    content_for(:bottom_links).should have_tag("a[href=?]", subject_event_path(@subject.id, @event.id))
  end

  it "should have subject hidden field" do
    response.should have_tag("input#event_subject_id")
  end

end