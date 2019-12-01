class Dashboard::ProfileAlbumsController < Dashboard::DashboardController
  layout "profilealbums"
  def new
    @albums = Album.cat_user
    @profile_album = ProfileAlbum.new
    @profile = Profile.find(current_user.id)
  end
  
  def create
    @profile_album = ProfileAlbum.create(
      album_id: params[:album_id],
      profile_id: params[:profile_id]
    )
    redirect_to edit_dashboard_profile_path
  end
  
  def edit
    @albums = Album.cat_user
    @profile = Profile.find(current_user.id)
    @profile_album = @profile.profile_album
  end
  
  def update
    @profile = Profile.find(current_user.id)
    @profile_album = @profile.profile_album
    if @profile_album.update(
      album_id: params[:album_id],
      )
       redirect_to edit_dashboard_profile_path
     else
       render 'edit'
     end
  end

end