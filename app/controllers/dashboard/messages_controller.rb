class Dashboard::MessagesController < Dashboard::DashboardController

	def create
	    @conversation = Conversation.find_by(:id => params[:conversation_id])
	    @message = @conversation.message.build(message_params)
      @message.sender_id = current_user.id
      @message.recipient_id = @conversation.recipient_id #這邊是錯的
        
      respond_to do |format|
        if @message.save
          #format.html { redirect_to dashboard_conversation_path(@conversation) }
          #format.js   { }
          format.json { 
            render json:{
              html_data: render_to_string(partial: 'dashboard/messages/message', :formats => [:html], locals: {message: @message})
            }
          }
          #render json: {
            #html_data: render_to_string(partial: 'dashboard/messages/message', locals: { message: @message })
          #} //可用，但不必有respond_to do |format|
          #format.json { render json: @message.to_json, status: :ok } //資料有回傳，但不知道怎麼放到html裡面
          #format.json { 
            #render json: {:message => @message, :template => "dashboard/messages/message", status: :ok}
          #} //資料有回傳，但不知道怎麼放到html裡面
        else
          format.json { render json: @message.errors, status: :unprocessable_entity }
          #format.json { 
            #render json:{ 
              #:errors => @message.errors.as_json, :status => :unprocessable_entity 
            #}
          #}
        end
      end
	end
	private
    
  def message_params
      params.require(:message).permit(:content)
  end
  
	
end
