require 'spec_helper'

describe AtaController do
  fixtures :records, :tasks, :events, :subjects, :members

  context "POST ata" do
    before :each do
      post :ata, :date => "20/12/2009", :atendees => [members(:joao).id, members(:lucianna).id]
    end

    it "should be success" do
      response.should be_success
    end

    it "should assigns atendees, subjects and date for the day given" do
      (assigns[:subjects] - [subjects(:bife), subjects(:copa_usp)]).should == []
      (assigns[:atendees] - [members(:joao), members(:lucianna)]).should == []
      assigns[:date].should == "20/12/2009"
    end
  end

  context "GET new" do
    before :each do
      get :new
    end

    it "should be success" do
      response.should be_success
    end

    it "should assigns all members to atendees" do
      (assigns[:atendees] - [members(:joao), members(:lucianna), members(:thiago)]).should == []
    end
  end
end