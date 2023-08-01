class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  # def create
  #   current_user.follow(params[:user_id])
  #   redirect_back(fallback_location: root_path)
  # end

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  # def destroy
  #   current_user.unfollow(params[:user_id])
  #   redirect_back(fallback_location: root_path)
  # end

  def destroy
    user = User.find(params[:user_id])
    curent_user.unfollow(user)
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
