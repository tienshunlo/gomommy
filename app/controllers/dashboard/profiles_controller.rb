class Dashboard::ProfilesController < Dashboard::DashboardController
    def new
    end
    def show
        @profile = Profile.find(current_user.id)
        @city = City.find(@profile.location).name
    end
    def edit
        @profile = Profile.find(current_user)
    end
    def update
        @profile = Profile.find(current_user.id)
        if @profile.update(profile_params)
            redirect_to dashboard_profile_path
        else
            render 'edit'
        end
    end
    
    def edit_registration
        @profile = Profile.find(current_user.id)
    end
    

    
    private
    
    def profile_params
        params.require(:profile).permit(:profile_img, :city_id, :location)
    end

end
