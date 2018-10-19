class Dashboard::ConversationsController < Dashboard::DashboardController
	layout "dashboard", :except => :show
	
	def show
	    @conversation = Conversation.find(params[:id])
	    @messages  = @messages_paginate = @conversation.message.includes(:user).order('id DESC').paginate(:page => params[:page], :per_page => 5)
	    if @conversation.sender == current_user
	        @user = @conversation.recipient
	    elsif @conversation.recipient == current_user
	        @user = @conversation.sender
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
