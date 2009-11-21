ActionController::Routing::Routes.draw do |map|
  map.resources :subjects, :as => "assuntos" do |subject|
    subject.resources :tasks, :as => "tarefas", :except => [:index]
  end

  map.change_status_subjects_task "/assuntos/:subject_id/tarefas/:id/change_status", {:controller => 'tasks', :action => 'change_status'}

  map.root :controller => "subjects", :action => "index"
end
