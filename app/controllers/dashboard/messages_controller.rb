class Dashboard::MessagesController < Dashboard::DashboardController

	def create
	    @conversation = Conversation.find_by(:id => params[:conversation_id])
	    @message = @conversation.message.build(message_params)
	    @message.user_id = current_user.id
      #@message.sender_id = current_user.id
      #@message.recipient_id = @conversation.recipient_id #這邊是錯的，收件夾裡面的訊息，寄件者會跟收件者一樣。
        
      respond_to do |format|
        if @message.save
          format.js   { }
        else
          format.js
        end
      end
	end
	private
    
  def message_params
      params.require(:message).permit(:content)
  end
  
	
end
