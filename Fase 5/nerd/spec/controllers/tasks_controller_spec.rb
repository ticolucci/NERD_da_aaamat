require 'spec_helper'

describe TasksController do
  fixtures :statuses, :tasks, :subjects

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

    it "should create a task with correct parameters" do
      post :create, :task => valid_attributes, :subject_id => subjects(:bife).id
      task = Task.find_by_title("a title")
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
end