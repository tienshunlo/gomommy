class Dashboard::ConversationsController < Dashboard::DashboardController
	def index
	    #@conversations = current_user.received_conversation.all
	    @conversations = @paginate = current_user.received_conversation.paginate(:page => params[:page], :per_page => 5)
	end
	
end
