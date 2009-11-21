require 'spec_helper'

describe SubjectsController do
  fixtures :subjects, :tasks

  def mock_subject
    @mock_subject ||= mock_model(Subject)
  end

  context "GET index" do

    before :each do
      get :index
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign all subjects in the system to subjects" do
      assigns[:subjects].should == [subjects(:bife), subjects(:copa_usp)]
    end
  end

  context "GET new" do
    before :each do
      Subject.stub!(:new).and_return(mock_subject)
      get :new
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign new subject" do
      assigns[:subject].should == mock_subject
    end
  end

  context "POST create" do
    it "should create a subject with correct parameters" do
      post :create, :subject => { :title => "new subject" }
      subject = Subject.find_by_title("new subject")
      subject.should_not be_nil
      response.should redirect_to(subject_path(subject.id))
    end

    it "should not create a subject with invalid parameters" do
      post :create, :subject => { :title => "" }
      Subject.find_by_title("").should be_nil
      response.should render_template(:new)
    end
  end

  context "DELETE destroy" do
    it "should destroy a subject" do
      delete :destroy, :id => subjects(:bife).id
      lambda{Subject.find subjects(:bife)}.should raise_error(ActiveRecord::RecordNotFound)
      response.should redirect_to(subjects_path)
    end
  end

  context "GET show" do
    before :each do
      get :show, :id => subjects(:bife).id
    end

    it "should be success" do
      response.should be_success
    end

    it "should assign the correct subject to subject" do
      assigns[:subject].should == subjects(:bife)
    end

    it "should assign a list of tasks to tasks" do
      assigns[:tasks].should == [tasks(:falar_com_diretor), tasks(:arrumar_deposito)]
    end
    
end

  context "GET edit" do
    before :each do
      get :edit, :id => subjects(:bife).id
    end
    
    it "should be success" do
      response.should be_success
    end

    it "should assign the correct subject to subject" do
      assigns[:subject].should == subjects(:bife)
    end
  end

  context "PUT update" do
    it "should be redirected if all went well" do
      put :update, :id => subjects(:bife).id, :subject => {:title => "Bife"}
      response.should redirect_to(subject_path(subjects(:bife).id))
    end

    it "should update the database" do
      old_title = subjects(:bife).title
      put :update, :id => subjects(:bife).id, :subject => {:title => "Bife"}
      new_title = Subject.find(subjects(:bife)).title
      new_title.should_not == old_title
      new_title.should == "Bife"
    end

    it "should render action edit if invalid parameters" do
      put :update, :id => subjects(:bife).id, :subject => {:title => ""}
      response.should render_template(:edit)
    end
  end
end
