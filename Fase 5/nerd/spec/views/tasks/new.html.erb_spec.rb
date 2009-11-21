require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/new" do
  fixtures :tasks, :statuses, :subjects, :members

  before :each do
    assigns[:task] = Task.new
    assigns[:subject] = @subject = subjects(:bife)
    assigns[:members] = @members = [members(:thiago)]
    assigns[:task_members] = @task_members = [members(:thiago)]
    render
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
      with_tag 'table' do
        with_tag 'tr' do
          with_tag 'td' do
            with_tag 'input', :value => @members.first.id
            with_tag 'label', @members.first.name
          end
        end
      end
    end
  end

  it "should have title" do
    response.should have_tag("h1", "Nova Tarefa")
  end

  it "should have a way to cancel" do
    response.should have_tag("a[href=?]", subject_path(@subject.id))
  end

  it "should have subject hidden field" do
    response.should have_tag("input#task_subject_id")
  end

end