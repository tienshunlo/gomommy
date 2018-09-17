class ConversationsController < ApplicationController
    
    before_action :find_user, only: [:create]
    def new
        @conversation = Conversation.new
        respond_to do |format|
          #format.html
          format.js
        end
    end
    
    def create
        @user = User.find(session[:recipient_id])
        @conversation = Conversation.create(conversation_params)
        @conversation.sender_id = current_user.id
        @conversation.recipient_id = session[:recipient_id]
        #if @conversation.save
            #format.html { redirect_to dashboard_conversation_path(@conversation) }
        #else
          #@user = User.find(session[:recipient_id])
          #render "users/show"
          #redirect_to user_path(@user) , :flash => { :error => @conversation.errors.full_messages.join(', ') }
        #end
        respond_to do |format|
          if @conversation.save
            format.html { redirect_to dashboard_conversation_path(@conversation) }
            format.js   { }
          else
            # 其實不需要這行也可以 @user = User.find(session[:recipient_id])
            # success: format.html { redirect_to :back, :flash => { :error => @conversation.errors.full_messages.join(', ') } }
            # failed: format.html { render "users/show"  } 
            format.html { render user_path(@user)  } #failed
            #format.html { redirect_to user_path(@user) }
            # 為什麼不能用alert? format.html { redirect_to :controller => :users, :action => :show, :id => @user.id, :alert => { :error => @conversation.errors.full_messages.join(', ') } }
            # 錯誤訊息會跑到網址列 format.html { redirect_to :controller => :users, :action => :show, :id => @user.id, :flash => { :error => @conversation.errors.full_messages.join(', ') } }
            # no routes format.html { redirect_to :controller => :users, :action => :show, :flash => { :error => @conversation.errors.full_messages.join(', ') } }
            #format.html { redirect_to :back , :flash => { :error => @conversation.errors.full_messages.join(', ') }}
            #format.html { redirect_to user_path(@user), :flash => { :error => @conversation.errors.full_messages.join(', ') } }
            #format.html { render template: "conversations/new", params: { id: @user.id } }
            #format.html { render :template => "users/show", params: { id: @user.id } }
            #format.html { render "users/show",  @user => User.find(session[:recipient_id]) }
            #format.js # call create.js.erb on save errors
            #format.json { render json: @conversation.errors, status: :unprocessable_entity }
          end
        end
    end
    
    private
    
    def conversation_params
        params.require(:conversation).permit(:content)
    end
    def find_user
  		@user = User.find(session[:recipient_id])
  	end
end
