require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/subjects/show" do
  fixtures :subjects, :tasks, :events, :records

  before :each do
    assigns[:subject] = @subject = subjects(:bife)
    assigns[:tasks] = @tasks = [tasks(:falar_com_diretor)]
    assigns[:events] = @events = [events(:abate)]
    assigns[:records] = @records = [records(:ovos)]
    render :layout => "application"
  end

  it "should render title" do
    response.should have_tag("h1", subjects(:bife).title)
  end

  it "should have a link to index" do
    response.should have_tag("a[href=?]", subjects_path)
  end

  it "should have a link to edit" do
    response.should have_tag("a[href=?]", edit_subject_path(subjects(:bife).id))
  end

  it "should have a table of tasks" do
    task = @tasks.first
    response.should have_tag("h2", "Tarefas")
    response.should have_tag("table#tasks") do
      with_tag("tr", :id=>"task_#{task.id}") do
        with_tag("td") do
          with_tag("a", task.title, :href => subject_task_path(task.subject.id, task.id))
        end
      end
    end
  end

  it "should have a table of events if it has events" do
    event = @events.first
    response.should have_tag("h2", "Eventos")
    response.should have_tag("table#events") do
      with_tag("tr", :id=>"event_#{event.id}") do
        with_tag("td") do
          with_tag("a", event.title, :href => subject_event_path(event.subject.id, event.id))
        end
      end
    end
  end

  it "should have a table of records if it has records" do
    record = @records.first
    response.should have_tag("h2", "Registros")
    response.should have_tag("table#records") do
      with_tag("tr", :id=>"records_#{record.id}") do
        with_tag("td") do
          with_tag("a", record.title, :href => subject_record_path(record.subject.id, record.id))
        end
      end
    end
  end

  it "should have a way to create a new task" do
    response.should have_tag("a[href=?]", new_subject_task_path(@subject.id))
  end

  it "should have a way to create a new event" do
    response.should have_tag("a[href=?]", new_subject_event_path(@subject.id))
  end

  it "should have a way to create a new record" do
    response.should have_tag("a[href=?]", new_subject_record_path(@subject.id))
  end

  it "should render the link to destroy a task" do
    response.should have_tag("a[href=?]", subject_task_path(subjects(:bife).id, tasks(:falar_com_diretor).id))
  end

  it "should render the link to edit a task" do
    response.should have_tag("a[href=?]", edit_subject_task_path(subjects(:bife).id, tasks(:falar_com_diretor).id))
  end

  it "should have a link to delete the subject" do
    content_for(:top_links).should have_tag("a[href=?]", subject_path(subjects(:bife).id))
  end
end

