class Dashboard::Mamabook::CitiesController < Dashboard::Mamabook::MamabookController
  before_action :find_city, only:[:edit]
  def index
    @cities = City.all
  end
  def edit
  end
  private
  def find_city
    @city = City.find(params[:id])
  end
end


