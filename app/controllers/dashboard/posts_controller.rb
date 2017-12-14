class Dashboard::PostsController < Dashboard::DashboardController
    
    def index
        @posts = @paginate = current_user.post.paginate(:page => params[:page], :per_page => 5)
        @profile = current_user.profile
    end
    
end
