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

  it "should route all crud actions for tasks as tarefas except for index" do
    params_from(:get, "/assuntos/1/tarefas/2").should == {:controller => "tasks", :action => "show", :subject_id => "1", :id => "2"}

    route_for(:controller => "tasks", :action => "show", :subject_id => "1", :id => "2").should == {:path => "/assuntos/1/tarefas/2", :method => :get}
  end

  it "should route change_status action for task" do
    params_from(:get, "/assuntos/1/tarefas/2/change_status").should == {:controller => "tasks", :action => "change_status", :subject_id => "1", :id => "2"}

    route_for(:controller => "tasks", :action => "change_status", :subject_id => "1", :id => "2").should == {:path => "/assuntos/1/tarefas/2/change_status", :method => :get}
  end

  it "should route all crud actions for events as eventos except for index" do
    params_from(:get, "/assuntos/1/eventos/2").should == {:controller => "events", :action => "show", :subject_id => "1", :id => "2"}

    route_for(:controller => "events", :action => "show", :subject_id => "1", :id => "2").should == {:path => "/assuntos/1/eventos/2", :method => :get}
  end

  it "should route all crud actions for records as registros except for index" do
    params_from(:get, "/assuntos/1/registros/2").should == {:controller => "records", :action => "show", :subject_id => "1", :id => "2"}

    route_for(:controller => "records", :action => "show", :subject_id => "1", :id => "2").should == {:path => "/assuntos/1/registros/2", :method => :get}
  end

  it "should route new, create and destroy actions for reminder as lembretes" do
    params_from(:get, "/lembretes/novo").should == {:controller => "reminders", :action => "new"}

    route_for(:controller => "reminders", :action => "new").should == {:path => "/lembretes/novo"}

    params_from(:post, "/lembretes").should == {:controller => "reminders", :action => "create"}

    route_for(:controller => "reminders", :action => "create").should == {:path => "/lembretes", :method => "post"}

    params_from(:delete, "/lembretes/1").should == {:controller => "reminders", :action => "destroy", :id => "1"}

    route_for(:controller => "reminders", :action => "destroy", :id => "1").should == {:path => "/lembretes/1", :method => :delete}
  end

  it "should route ata and new requests to Ata" do
    params_from(:post, "/ata").should == {:controller => "ata", :action => "ata"}

    route_for(:controller => "ata", :action => "ata").should == {:path => "/ata", :method => "post"}

    params_from(:get, "/ata/novo").should == {:controller => "ata", :action => "new"}

    route_for(:controller => "ata", :action => "new").should == {:path => "/ata/novo"}
  end
end
