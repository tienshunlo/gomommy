class Dashboard::Mamabook::DoctorAlbumsController < Dashboard::Mamabook::MamabookController
  
  def new
    @albums = Album.cat_doctor
    @doctoralbum = DoctorAlbum.new
  end
  
  def create
    @doctoralbum = DoctorAlbum.create(
      album_id: params[:album_id],
      doctor_id: params[:doctor_id]
    )
    redirect_to dashboard_mamabook_doctors_path
  end
  
  def edit
    @albums = Album.cat_doctor
    
    @doctor = Doctor.find(params[:doctor_id])
    @doctoralbum = DoctorAlbum.find_by(params[:id])
    
  end
  
  def update
    @doctoralbum = DoctorAlbum.find(params[:id])
    if @doctoralbum.update(
      album_id: params[:album_id],
      doctor_id: params[:doctor_id]
      )
       redirect_to dashboard_mamabook_doctors_path
     else
       render 'edit'
     end
  end

end