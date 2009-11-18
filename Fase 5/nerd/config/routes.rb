ActionController::Routing::Routes.draw do |map|
  map.resources :subjects, :as => "assuntos"

  map.root :controller => "subjects", :action => "index"
end
