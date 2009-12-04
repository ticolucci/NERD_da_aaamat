ActionController::Routing::Routes.draw do |map|
  map.resources :subjects, :as => "assuntos" do |subject|
    subject.resources :tasks, :as => "tarefas", :except => [:index]
    subject.resources :events, :as => "eventos", :except => [:index]
    subject.resources :records, :as => "registros", :except => [:index]
  end

  map.resources :reminders, :as => "lembretes", :except => [:index, :show, :update, :edit]
  
  map.change_status_subjects_task "/assuntos/:subject_id/tarefas/:id/change_status", {:controller => 'tasks', :action => 'change_status'}

  map.ata "/ata", {:controller => 'ata', :action => 'ata'}
  map.new_ata "/ata/novo", {:controller => 'ata', :action => 'new'}

  map.root :controller => "subjects", :action => "index"
end
