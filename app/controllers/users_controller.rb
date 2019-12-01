class UsersController < ApplicationController
  before_action :set_recipient, :only => :show
  before_action :authenticate_user!, only: [:show]
  def show
    @user = User.find(params[:id])
    @posts = @user.post
    @profile = @user.profile
    #@city = City.find(@profile.location).name
    @conversation = Conversation.new
  end
  
  def set_recipient
    session[:recipient_id] = params[:id] if params[:id]
  end
end
