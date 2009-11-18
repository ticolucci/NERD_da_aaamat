# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  helper_method :back_or
  
  private
  
    def store_location
      session[:location] = request.request_uri
    end

    def back_or(url=root_path)
      session[:location] || url
    end
end
