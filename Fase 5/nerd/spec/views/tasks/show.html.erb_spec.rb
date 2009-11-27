require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/show" do
  fixtures :tasks, :statuses, :subjects, :members, :reminders

  before :each do
    assigns[:task] = @task = tasks(:falar_com_diretor)
    assigns[:subject] = @subject = subjects(:bife)
    assigns[:members] = @members = [members(:lucianna)]
    assigns[:reminders] = @reminders = [reminders(:lembrete1), reminders(:lembrete2)]
    render :layout => "application"
  end

  it "should show the title as heading" do
    response.should have_tag("h1", @task.title)
  end

  it "should show status" do
    response.should have_tag("h1") do
      with_tag("img", :src => /#{@task.status.status_type}/)
    end
  end

  it "should show all attributes" do
    response.should have_tag("div#task_attributes") do
      with_tag("p", /#{@task.body}/) do
        with_tag("label", "Corpo:")
      end
      with_tag("p", /#{l(@task.due_date)}/) do
        with_tag("label", "Data limite para realização:")
      end
      with_tag("p", /#{l(@task.created_at)}/) do
        with_tag("label", "Data de criação:")
      end
      with_tag "ul" do
        with_tag "li", "Lucianna"
      end
      with_tag "ul" do
        with_tag "li", "25/12/2009"
      end
    end
  end

  it "should be able to go to subject" do
    response.should have_tag("a[href=?]", subject_path(@subject.id))
  end

  it "should render the link to edit a subject" do
    response.should have_tag("a[href=?]", edit_subject_task_path(subjects(:bife).id, tasks(:falar_com_diretor).id))
  end

  it "should have a link to delete the task" do
    content_for(:top_links).should have_tag("a[href=?]", subject_task_path(subjects(:bife).id, tasks(:falar_com_diretor).id))
  end

  it "should have a link to create a reminder" do
    response.should have_tag("a") do
      with_tag "img"
    end
  end

end