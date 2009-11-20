require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/show" do
  fixtures :tasks, :statuses, :subjects

  before :each do
    assigns[:task] = @task = tasks(:falar_com_diretor)
    assigns[:subject] = @subject = subjects(:bife)
    render
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
      with_tag("p", /#{l(@task.due_date)}/) do
        with_tag("label", "Data de criação:")
      end
    end
  end

  it "should be able to go to subject" do
    response.should have_tag("a[href=?]", subject_path(@subject.id))
  end

end