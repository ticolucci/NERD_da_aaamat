require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/subjects/show" do
  fixtures :subjects, :tasks
  
  before :each do
    assigns[:subject] = @subject = subjects(:bife)
    assigns[:tasks] = @tasks = [tasks(:falar_com_diretor)]
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

  it "should have a table of tasks" do
    task = @tasks.first
    response.should have_tag("table#tasks") do
      with_tag("tr", :id=>"task_#{task.id}") do
        with_tag("td") do
          with_tag("a", task.title, :href => subject_task_path(task.subject.id, task.id))
        end
      end
    end
  end

  it "should have a way to create a new task" do
    response.should have_tag("a[href=?]", new_subject_task_path(@subject.id))
  end

  it "should render the link to destroy a subject" do
    response.should have_tag("a[href=?]", subject_task_path(subjects(:bife).id, tasks(:falar_com_diretor).id))
  end
end