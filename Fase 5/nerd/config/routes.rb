ActionController::Routing::Routes.draw do |map|
  map.resources :subjects, :as => "assuntos" do |subject|
    subject.resources :tasks, :as => "tarefas", :except => [:index]
  end

  map.root :controller => "subjects", :action => "index"
end
