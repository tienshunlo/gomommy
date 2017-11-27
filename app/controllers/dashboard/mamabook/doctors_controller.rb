class Dashboard::Mamabook::DoctorsController < Dashboard::Mamabook::MamabookController
  before_action :find_doctor, only:[:edit, :update, :destroy, :toggle_status]

  def index
    @doctors = @paginate = Doctor.includes(:post).paginate(:page => params[:page], :per_page => 5)
  end
  
  def new
    @doctor = Doctor.new
  end
  
  def create
    @doctor = Doctor.create(doctor_params)
    if @doctor.save
      redirect_to dashboard_mamabook_doctors_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @doctor.update(doctor_params)
      redirect_to dashboard_mamabook_doctors_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @doctor.destroy
    redirect_to dashboard_mamabook_doctors_path, notice: 'Doctor was removed.'
  end
  
  def toggle_status
	  if @doctor.draft?
	    @doctor.published!
	  else
	    @doctor.draft!
	  end
	  redirect_to dashboard_mamabook_doctors_path
	end

  private
  
  def doctor_params
		params.require(:doctor).permit(:name, :specialty, :experience, :doctor_img)
	end
	
  def find_doctor
    @doctor = Doctor.find(params[:id])
  end
  def doctor_params
    params.require(:doctor).permit( :name,
                                    :specialty,
                                    :experience, 
                                    :doctor_img,
                                    :hospital_id,
                                    :gender,
                                    :city_id,
                                    :district_id,
                                    :post_count,
                                    :impressions_count,
                                    :slug
                                    )
  end
end