require 'spec_helper'

describe EventsController do
  fixtures :statuses, :events, :subjects, :members

  context "GET show" do
    before :each do
      get :show, :subject_id => subjects(:bife).id, :id => events(:abate).id
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign event to @event" do
      assigns[:event].should == events(:abate)
    end

    it"should assign the subject from event to @subject" do
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

    it "should assign a new event to event" do
      assigns[:event].should be_new_record
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
        :time => "15:10:09",
        :date => "12/12/1212",
        :subject_id => subjects(:bife).id
      }.merge options
    end

    it "should create a event with correct parameters" do
      post :create, :event => valid_attributes, :subject_id => subjects(:bife).id
      event = Event.find_by_title("a title")

      event.time.should_not be_nil
    end

    it "should redirect to subject if creation was succesful" do
      post :create, :event => valid_attributes, :subject_id => subjects(:bife).id
      response.should redirect_to(subject_path(subjects(:bife).id))
    end

    it "should render new if creation went wrong" do
      post :create, :event => valid_attributes(:title => ""), :subject_id => subjects(:bife).id
      response.should render_template(:new)
    end

    it "should assign subject to @subject" do
      post :create, :event => valid_attributes, :subject_id => subjects(:bife).id
      assigns[:subject].should == subjects(:bife)
    end
  end

  context "DELETE destroy" do
    it "should destroy a event" do
      old_count = Event.count
      delete :destroy, :id => events(:abate), :subject_id => subjects(:bife)
      new_count = Event.count
      (old_count - new_count).should == 1
    end

    it "should redirect to event list" do
      delete :destroy, :id => events(:abate), :subject_id => subjects(:bife)
      response.should redirect_to(subject_path(subjects(:bife).id))
    end
  end

  context "GET edit" do
    before :each do
      get :edit, :subject_id => subjects(:bife).id, :id => events(:abate).id
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign the correct subject to subject and event to event" do
      assigns[:subject].should == subjects(:bife)
      assigns[:event].should == events(:abate)
    end
  end

  context "PUT update" do

    it "should be redirected if all went well" do
      put :update, :subject_id => subjects(:bife).id, :id => events(:abate).id, :event => {:title => "new title"}
      response.should redirect_to(subject_event_path(subjects(:bife).id, events(:abate).id))
    end

    it "should update the database" do
      old_title = events(:abate).title
      put :update, :subject_id => subjects(:bife).id,
                   :id => events(:abate).id, :event => {:title => "new title"}

      event = Event.find(events(:abate))
      new_title = event.title
      new_title.should_not == old_title
      new_title.should == "new title"
    end

    it "should render action edit if invalid parameters" do
      put :update, :subject_id => subjects(:bife).id, :id => events(:abate).id, :event => {:title => ""}
      response.should render_template(:edit)
    end
  end
end