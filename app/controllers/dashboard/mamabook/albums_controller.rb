class Dashboard::Mamabook::AlbumsController < Dashboard::Mamabook::MamabookController
  def index
    @albums = Album.all
  end
  
  def new
    @album = Album.new
  end
  
  def create
    @album = Album.create(album_params)
    if @album.save
      redirect_to dashboard_mamabook_albums_path
    else
      render 'new'
    end
  end
  
  def toggle_category
    @album = Album.find(params[:id])
    if @album.update(category: params[:category])
      redirect_to dashboard_mamabook_albums_path
    else
      render 'edit'
    end
  end
  
  private
  def album_params
    params.require(:album).permit(:album_img)
  end
  
end

