require 'spec_helper'

describe "routes" do
  it "should route root to index of subject" do
    params_from(:get, "/").should == {:controller => "subjects", :action => "index"}

    params_from(:get, "/subjects").should == {:controller => "subjects", :action => "index"}
    
    route_for(:controller => "subjects", :action => "index").should == "/subjects"
  end

  it "should route new to new of subject" do
    params_from(:get, "/subjects/new").should == {:controller => "subjects", :action => "new"}

    route_for(:controller => "subjects", :action => "new").should == "/subjects/new"
  end

  it "should route create for subject" do
    params_from(:post, "/subjects").should == {:controller => "subjects", :action => "create"}

    route_for(:controller => "subjects", :action => "create").should == {:path => "/subjects", :method => :post}

  end
end
