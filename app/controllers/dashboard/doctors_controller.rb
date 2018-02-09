class Dashboard::DoctorsController < Dashboard::DashboardController
	def index
	    @doctors = @paginate = Doctor.paginate(:page => params[:page], :per_page => 5)
	    @profile = current_user.profile
	end
	def up_voted_doctors
    	@doctors = current_user.get_up_voted Doctor
    end
end
