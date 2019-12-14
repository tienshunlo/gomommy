class Dashboard::Mamabook::CitiesController < Dashboard::Mamabook::MamabookController
  before_action :find_city, only:[:edit, :update, :destroy]
  def index
    @cities = City.all
  end
  def edit
    @district = @city.district.all
  end
  def destroy
    @city.destroy
    redirect_to dashboard_mamabook_cities_path, notice: 'City was removed.'
  end
  def update
    if @city.update(city_params)
      redirect_to dashboard_mamabook_cities_path
    else
      render 'edit'
    end
  end
  private
  def find_city
    @city = City.find(params[:id])
  end
  def city_params
    params.require(:city).permit(:name, :district_attributes => [:id, :name])
  end
end


