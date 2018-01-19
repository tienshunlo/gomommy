class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.post
    @profile = @user.profile
    @city = City.find(@profile.location).name
  end
end
