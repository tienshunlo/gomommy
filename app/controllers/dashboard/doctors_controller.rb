class Dashboard::DoctorsController < Dashboard::DashboardController
	def index
	    @doctors = @paginate = Doctor.paginate(:page => params[:page], :per_page => 5)
	    @profile = current_user.profile
	end
end
