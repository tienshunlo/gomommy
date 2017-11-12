class Dashboard::DashboardController < ApplicationController
  layout "dashboard"
  def posts
    @posts = @paginate = Post.includes(:doctor).paginate(:page => params[:page], :per_page => 5)
  end
  
  def doctors
    @doctors =@paginate = Doctor.paginate(:page => params[:page], :per_page => 5)
  end
end
