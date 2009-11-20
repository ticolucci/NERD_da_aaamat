require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/show" do
  fixtures :tasks, :statuses

  before :each do
    assigns[:task] = @task = tasks(:falar_com_diretor)
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

end