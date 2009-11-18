require 'spec_helper'

describe "routes" do
  it "should route root to index of subject as assunto" do
    params_from(:get, "/").should == {:controller => "subjects", :action => "index"}

    params_from(:get, "/assuntos").should == {:controller => "subjects", :action => "index"}
    
    route_for(:controller => "subjects", :action => "index").should == "/assuntos"
  end

  it "should route new to new of subject as novo" do
    params_from(:get, "/assuntos/novo").should == {:controller => "subjects", :action => "new"}

    route_for(:controller => "subjects", :action => "new").should == "/assuntos/novo"
  end

  it "should route create for subject" do
    params_from(:post, "/assuntos").should == {:controller => "subjects", :action => "create"}

    route_for(:controller => "subjects", :action => "create").should == {:path => "/assuntos", :method => :post}
  end
end
