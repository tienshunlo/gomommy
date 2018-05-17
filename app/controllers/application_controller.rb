class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include DefaultPageContent
  include DeviseWhitelist
  
  before_action :store_user_location!, if: :storable_location?
  before_action :set_copyright
  
  def set_copyright
    @copyright = MamabookViewTool::Renderer.copyright "Mamabook", "All rights reserved"
  end

  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end
end

module MamabookViewTool
  class Renderer
    def self.copyright name, msg
      "&copy: #{Time.now.year} | <b>#{name}</b> #{msg}".html_safe
    end
  end
end