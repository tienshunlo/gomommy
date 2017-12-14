class Users::SessionsController < Devise::SessionsController

    protected
    def after_sign_in_path_for(resource) 
        if current_user.published?
          root_path(resource)
        else
          edit_dashboard_profile_path(resource)
        end
    end
    def after_sign_out_path_for(resource_or_scope)
        posts_path
    end
end
