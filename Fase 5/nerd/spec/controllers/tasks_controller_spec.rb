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
  end
end