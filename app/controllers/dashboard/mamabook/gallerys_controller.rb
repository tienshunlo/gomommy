class Dashboard::Mamabook::GallerysController < Dashboard::Mamabook::MamabookController
  def index
    @gallerys = Gallery.all
  end
  
  def new
    @gallery = Gallery.new
  end
  
  def create
    @gallery = Gallery.create(gallery_params)
    if @gallery.save
      redirect_to dashboard_mamabook_doctors_path
    else
      render 'new'
    end
  end
  
  private
  def gallery_params
    params.require(:gallery).permit(:gallery_img)
  end
  
end