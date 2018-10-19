class ConversationsController < ApplicationController
    
    def new
        @conversation = Conversation.new
        respond_to do |format|
          format.js
        end
    end
    
    def create
        @user = User.find(session[:recipient_id])
        @conversation = Conversation.create(conversation_params)
        @conversation.sender_id = current_user.id
        @conversation.recipient_id = session[:recipient_id]
        respond_to do |format|
          if @conversation.save
            format.html { redirect_to dashboard_conversation_path(@conversation) }
            # format.js   { }
          else
            format.html { redirect_to user_path(@user), :flash => { :error => @conversation.errors.full_messages.join(', ') } }
            # 其實不需要這行也可以 @user = User.find(session[:recipient_id])
            # success: format.html { redirect_to :back, :flash => { :error => @conversation.errors.full_messages.join(', ') } }
            # failed: format.html { render "users/show"  } 
            # failed: format.html { render user_path(@user)  } 
            # failed: no routes format.html { redirect_to :controller => :users, :action => :show, :flash => { :error => @conversation.errors.full_messages.join(', ') } }
            # format.js # call create.js.erb on save errors
            # format.json { render json: @conversation.errors, status: :unprocessable_entity }
          end
        end
    end
    
    private
    
    def conversation_params
        params.require(:conversation).permit(:content)
    end
end
