class Dashboard::PostsController < Dashboard::DashboardController
    def index
        @posts = @paginate = current_user.post.paginate(:page => params[:page], :per_page => 5)
        @profile = current_user.profile
    end
    def visited_pages
        @visited_page = current_user.profile.visited
    end
    def up_voted_items
        @up_voted_items = current_user.get_up_voted Post
    end
end