ActionController::Routing::Routes.draw do |map|
  map.resources :subjects

  map.root :controller => "subjects", :action => "index"
end
