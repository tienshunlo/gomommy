class Dashboard::ConversationsController < Dashboard::DashboardController
	
	def show
	    @conversation = Conversation.find_by(:id => params[:id])
	    if @conversation.sender == current_user || @conversation.recipient == current_user
	        render 'show'
	    else
	        redirect_to root_path
	    end
	end
	def inbox
		@conversations = @paginate = current_user.received_conversation.paginate(:page => params[:page], :per_page => 5).order('id DESC')
	end
    def outbox
    	@conversations = @paginate = current_user.sent_conversation.paginate(:page => params[:page], :per_page => 5).order('id DESC')
    end
	
end
