class Dashboard::DoctorsController < Dashboard::DashboardController
	def index
	    @doctors = @paginate = Doctor.paginate(:page => params[:page], :per_page => 5)
	    @profile = current_user.profile
	end
	
	def up_voted_doctors
    	@doctors = current_user.get_up_voted(Doctor)
    end
    
    def bookmarked_doctors
    	@doctor_ids = current_user.bookmarkees_by(Doctor).map {|id| id.bookmarkee_id}
    	@bookmarked_doctors = Doctor.where(id:@doctor_ids)
    end
end
