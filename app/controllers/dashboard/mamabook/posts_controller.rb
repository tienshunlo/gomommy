class Dashboard::Mamabook::PostsController < Dashboard::Mamabook::MamabookController
  def index
    @posts = @paginate = Post.includes(:doctor).paginate(:page => params[:page], :per_page => 5)
  end
end