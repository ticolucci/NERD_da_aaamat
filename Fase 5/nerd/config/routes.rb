ActionController::Routing::Routes.draw do |map|
  map.resources :subjects, :only => [:index]

  map.root :controller => "subjects", :action => "index"
end
