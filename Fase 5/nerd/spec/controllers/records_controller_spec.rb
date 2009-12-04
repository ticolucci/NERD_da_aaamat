require 'spec_helper'

describe RecordsController do
  fixtures :statuses, :records, :subjects, :members

  context "GET show" do
    before :each do
      get :show, :subject_id => subjects(:bife).id, :id => records(:ovos).id
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign record to @record" do
      assigns[:record].should == records(:ovos)
    end

    it"should assign the subject from record to @subject" do
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

    it "should assign a new record to record" do
      assigns[:record].should be_new_record
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
        :subject_id => subjects(:bife).id
      }.merge options
    end

    it "should tell its subject that it has been changed" do
      post :create, :record => valid_attributes, :subject_id => subjects(:bife).id
      record = Record.find_by_title("a title")
      subject = Subject.find(subjects(:bife).id)

      subject.updated_at.should == record.created_at
    end

    it "should create a record with correct parameters" do
      post :create, :record => valid_attributes, :subject_id => subjects(:bife).id
      record = Record.find_by_title("a title")

      record.body.should_not be_nil
    end

    it "should redirect to subject if creation was succesful" do
      post :create, :record => valid_attributes, :subject_id => subjects(:bife).id
      response.should redirect_to(subject_path(subjects(:bife).id))
    end

    it "should render new if creation went wrong" do
      post :create, :record => valid_attributes(:title => ""), :subject_id => subjects(:bife).id
      response.should render_template(:new)
    end

    it "should assign subject to @subject" do
      post :create, :record => valid_attributes, :subject_id => subjects(:bife).id
      assigns[:subject].should == subjects(:bife)
    end
  end

  context "DELETE destroy" do

    it "should destroy a record" do
      old_count = Record.count
      delete :destroy, :id => records(:ovos), :subject_id => subjects(:bife)
      new_count = Record.count
      (old_count - new_count).should == 1
    end

    it "should redirect to record list" do
      delete :destroy, :id => records(:ovos), :subject_id => subjects(:bife)
      response.should redirect_to(subject_path(subjects(:bife).id))
    end
  end

  context "GET edit" do
    before :each do
      get :edit, :subject_id => subjects(:bife).id, :id => records(:ovos).id
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign the correct subject to subject and record to record" do
      assigns[:subject].should == subjects(:bife)
      assigns[:record].should == records(:ovos)
    end
  end

  context "PUT update" do

    it "should tell its subject that it has been changed" do
      post :update, :subject_id => subjects(:bife).id, :id => records(:ovos).id, :record => {:title => "new title"}
      record = Record.find_by_title("new title")
      subject = Subject.find(subjects(:bife).id)

      subject.updated_at.should == record.updated_at
    end

    it "should be redirected if all went well" do
      put :update, :subject_id => subjects(:bife).id, :id => records(:ovos).id, :record => {:title => "new title"}
      response.should redirect_to(subject_record_path(subjects(:bife).id, records(:ovos).id))
    end

    it "should update the database" do
      old_title = records(:ovos).title
      put :update, :subject_id => subjects(:bife).id,
                   :id => records(:ovos).id, :record => {:title => "new title"}

      record = Record.find(records(:ovos))
      new_title = record.title
      new_title.should_not == old_title
      new_title.should == "new title"
    end

    it "should render action edit if invalid parameters" do
      put :update, :subject_id => subjects(:bife).id, :id => records(:ovos).id, :record => {:title => ""}
      response.should render_template(:edit)
    end
  end
end