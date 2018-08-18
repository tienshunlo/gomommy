class Dashboard::MessagesController < Dashboard::DashboardController
	
	
	def create
	    @conversation = Conversation.find_by(:id => params[:conversation_id])
	    @message = @conversation.message.build(message_params)
        @message.sender_id = current_user.id
        @message.recipient_id = session[:recipient_id]
        respond_to do |format|
          if @message.save
            format.html { redirect_to dashboard_conversation_path(@conversation) }
            #format.js   { }
          else
            format.html { render :new }
            format.js # call create.js.erb on save errors
            format.json { render json: @message.errors, status: :unprocessable_entity }
          end
        end
	end
	private
    
    def message_params
        params.require(:message).permit(:content)
    end
	
end
