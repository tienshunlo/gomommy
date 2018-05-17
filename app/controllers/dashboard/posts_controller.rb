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
    def bookmarked_posts
    	@post_ids = current_user.bookmarkees_by(Post).map {|id| id.bookmarkee_id}
    	@bookmarked_posts = Post.where(id:@post_ids)
    end
end