require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/edit" do
  fixtures :tasks, :statuses, :subjects, :members

  before :each do
    assigns[:task] = @task = tasks(:falar_com_diretor)
    assigns[:subject] = @subject = subjects(:bife)
    assigns[:members] = @members = [members(:thiago)]
    assigns[:task_members] = @task_members = [members(:thiago)]
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
        with_tag 'label', 'Data limite para realização'
        with_tag 'input', :id => /due_date/
      end
      with_tag 'p' do
        with_tag("input", :id => "task_submit")
      end
    end
  end

  it "should have title" do
    response.should have_tag("h1", "Editando Tarefa")
  end

  it "should have a way to cancel" do
    response.should have_tag("a[href=?]", subject_task_path(@subject.id, @task.id))
  end

  it "should have subject hidden field" do
    response.should have_tag("input#task_subject_id")
  end

end