require 'spec_helper'

describe TasksController do
  fixtures :statuses, :tasks, :subjects, :members, :reminders

  context "GET show" do
    before :each do
      get :show, :subject_id => subjects(:bife).id, :id => tasks(:falar_com_diretor).id
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign task to @task" do
      assigns[:task].should == tasks(:falar_com_diretor)
    end

    it"should assign the subject from task to @subject" do
      assigns[:subject].should == subjects(:bife)
    end

    it "should assing the members to @members" do
      (assigns[:members] - [members(:lucianna), members(:joao)]).should be_empty
    end

    it "should assign the reminders to reminders" do
      (assigns[:reminders] - [reminders(:lembrete1), reminders(:lembrete2)]).should be_empty
    end
    
  end

  context "GET new" do
    before :each do
      get :new, :subject_id => subjects(:bife).id
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign a new task to task" do
      assigns[:task].should be_new_record
    end

    it "should assign subject to subject" do
      assigns[:subject].should == subjects(:bife)
    end

    it "should assing the members to @members" do
      assigns[:members].should == Member.find(:all)
    end

    it "should assing the members to @task_members" do
      (assigns[:task_members] - [members(:lucianna), members(:joao)]).should be_empty
    end
  end

  context "POST create" do
    def valid_attributes(options={})
      {
        :title => "a title",
        :body => "a body",
        :due_date => "15/10/2009",
        :subject_id => subjects(:bife).id
      }.merge options
    end

    it "should tell its subject that it has been changed" do
      post :create, :task => valid_attributes, :subject_id => subjects(:bife).id, :members_ids => [members(:joao).id, members(:thiago).id]
      task = Task.find_by_title("a title")
      subject = Subject.find(subjects(:bife).id)

      subject.updated_at.should == task.updated_at
    end

    it "should create a task with correct parameters" do
      post :create, :task => valid_attributes, :subject_id => subjects(:bife).id, :members_ids => [members(:joao).id, members(:thiago).id]
      task = Task.find_by_title("a title")
      task.members.should_not be_empty
      task.should_not be_nil
      task.due_date.should_not be_nil
    end

    it "should redirect to subject if creation was succesful" do
      post :create, :task => valid_attributes, :subject_id => subjects(:bife).id
      response.should redirect_to(subject_path(subjects(:bife).id))
    end

    it "should render new if creation went wrong" do
      post :create, :task => valid_attributes(:title => ""), :subject_id => subjects(:bife).id
      response.should render_template(:new)
    end

    it "should assign subject to @subject" do
      post :create, :task => valid_attributes, :subject_id => subjects(:bife).id
      assigns[:subject].should == subjects(:bife)
    end
  end

  context "POST change_status" do
    it "should go to doing if todo" do
      task = tasks(:pagar_laausp)
      task.status.should == statuses(:a_fazer)
      post :change_status, :id => task.id, :subject_id => task.subject.id
      Task.find(task.id).status.should == statuses(:fazendo)
    end

    it "should go to done if doing" do
      task = tasks(:falar_com_diretor)
      task.status.should == statuses(:fazendo)
      post :change_status, :id => task.id, :subject_id => task.subject.id
      Task.find(task.id).status.should == statuses(:feito)
    end

    it "should go to todo if done" do
      task = tasks(:arrumar_deposito)
      task.status.should == statuses(:feito)
      post :change_status, :id => task.id, :subject_id => task.subject.id
      Task.find(task.id).status.should == statuses(:a_fazer)
    end
  end

  context "DELETE destroy" do
    it "should destroy a task" do
      old_count = Task.count
      delete :destroy, :id => tasks(:falar_com_diretor), :subject_id => subjects(:bife)
      new_count = Task.count
      (old_count - new_count).should == 1
    end

    it "should redirect to task list" do
      delete :destroy, :id => tasks(:falar_com_diretor), :subject_id => subjects(:bife)
      response.should redirect_to(subject_path(subjects(:bife).id))
    end
  end

  context "GET edit" do
    before :each do
      get :edit, :subject_id => subjects(:bife).id, :id => tasks(:falar_com_diretor).id
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign the correct subject to subject and task to task" do
      assigns[:subject].should == subjects(:bife)
      assigns[:task].should == tasks(:falar_com_diretor)
    end

    it "should assing the members to @members" do
      assigns[:members].should == Member.find(:all)
    end

    it "should assing the members to @task_members" do
      (assigns[:task_members] - [members(:lucianna), members(:joao)]).should be_empty
    end
  end

  context "PUT update" do

    it "should tell its subject that it has been changed" do
      post :update, :subject_id => subjects(:bife).id, :id => tasks(:falar_com_diretor).id, :task => {:title => "new title"}
      task = Task.find_by_title("new title")
      subject = Subject.find(subjects(:bife).id)

      subject.updated_at.should == task.updated_at
    end

    it "should be redirected if all went well" do
      put :update, :subject_id => subjects(:bife).id, :id => tasks(:falar_com_diretor).id, :task => {:title => "new title"}
      response.should redirect_to(subject_task_path(subjects(:bife).id, tasks(:falar_com_diretor).id))
    end

    it "should update the database" do
      old_title = tasks(:falar_com_diretor).title
      put :update, :subject_id => subjects(:bife).id,
                   :id => tasks(:falar_com_diretor).id, :task => {:title => "new title"},
                   :members_ids => [members(:lucianna).id, members(:thiago).id]

      task = Task.find(tasks(:falar_com_diretor))
      new_title = task.title
      new_title.should_not == old_title
      new_title.should == "new title"

      task.members.should == [members(:lucianna), members(:thiago)]

    end

    it "should erase members if no members are given" do
      put :update, :subject_id => subjects(:bife).id,
                   :id => tasks(:falar_com_diretor).id, :task => {:title => "new title"}

      task = Task.find(tasks(:falar_com_diretor))
      task.members.should == []
    end

    it "should render action edit if invalid parameters" do
      put :update, :subject_id => subjects(:bife).id, :id => tasks(:falar_com_diretor).id, :task => {:title => ""}
      response.should render_template(:edit)
    end
  end
end