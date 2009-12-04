require 'spec_helper'

describe RemindersController do
  fixtures :tasks, :reminders, :events, :subjects

  context "GET new" do
    it "should be success" do
      get :new, :item_id => tasks(:falar_com_diretor).id, :item_type => tasks(:falar_com_diretor).class.to_s
      response.should be_success
    end

    it "should assign a new reminder to reminder" do
      get :new, :item_id => tasks(:falar_com_diretor).id, :item_type => tasks(:falar_com_diretor).class.to_s
      assigns[:reminder].should be_new_record
    end

    it "should assign task to item" do
      get :new, :item_id => tasks(:falar_com_diretor).id, :item_type => tasks(:falar_com_diretor).class.to_s
      assigns[:item].should == tasks(:falar_com_diretor)
    end

    it "should assign event to item" do
      get :new, :item_id => events(:abate).id, :item_type => events(:abate).class.to_s
      assigns[:item].should == events(:abate)
    end
  end

  context "POST create" do
    def valid_attributes(options={})
      {
        :date => "15/10/2009",
        :time => 1,
        :item_id => tasks(:falar_com_diretor).id,
        :item_type => tasks(:falar_com_diretor).class.to_s
      }.merge options
    end

    it "should create a reminder with correct parameters" do
      post :create, :reminder => valid_attributes
      reminder = Reminder.find_by_date("2009-10-15")
      reminder.should_not be_nil
    end

    it "should redirect to items path if creation was succesful" do
      post :create, :reminder => valid_attributes
      response.should redirect_to(subject_task_path(subjects(:bife).id, tasks(:falar_com_diretor).id))
    end

    it "should render new if creation went wrong" do
      post :create, :reminder => valid_attributes(:date => "")
      response.should render_template(:new)
    end

  end

  context "DELETE destroy" do
    it "should destroy a reminder" do
      old_count = Reminder.count
      delete :destroy, :id => reminders(:lembrete1).id
      new_count = Reminder.count
      (old_count - new_count).should == 1
    end
  end
end