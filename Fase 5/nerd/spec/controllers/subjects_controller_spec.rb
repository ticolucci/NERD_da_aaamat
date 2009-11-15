require 'spec_helper'

describe SubjectsController do
  fixtures :subjects

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

end
