class Dashboard::ProfilesController < Dashboard::DashboardController
    
    before_action :find_profile, :except => :new
    before_action :find_city, :except => :new
    
    def new
    end
    
    def show
        @profile = Profile.find(current_user.id)
        if @profile.location
            @city = City.find(@profile.location).name
        else
            @city = "請加入"
        end
    end
    
    def edit
        @citys = City.all
    end
    
    def update
        @citys = City.all
        if @profile.update(profile_params)
            redirect_to dashboard_profile_path
        else
            render 'edit'
        end
    end
    
    private
    
    def profile_params
        params.require(:profile).permit(:profile_img, :location, :number_of_baby, :nickname_of_baby, :gender_of_baby, :birthday_of_baby)
    end
    
    def find_profile
        @profile = Profile.find(current_user.id)
    end
    
    def find_city
        if current_user.profile.location
             @city = City.find(@profile.location).name
        end
    end

end
