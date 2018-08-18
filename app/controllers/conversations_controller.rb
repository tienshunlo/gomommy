class ConversationsController < ApplicationController
    def new
        @conversation = Conversation.new
        respond_to do |format|
          format.html
          format.js
        end
    end
    
    def create
        @conversation = Conversation.create(conversation_params)
        @conversation.sender_id = current_user.id
        @conversation.recipient_id = session[:recipient_id]
        respond_to do |format|
          if @conversation.save
            format.html { redirect_to dashboard_conversation_path }
            format.js   { }
          else
            format.html { render :new }
            format.js # call create.js.erb on save errors
            format.json { render json: @conversation.errors, status: :unprocessable_entity }
          end
        end
    end
    
    private
    
    def conversation_params
        params.require(:conversation).permit(:content)
    end
end
