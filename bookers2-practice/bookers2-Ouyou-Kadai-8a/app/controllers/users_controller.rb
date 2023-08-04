class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu| #current_userのもつentriesを1つずつ取り出す
        @userEntry.each do |u| #@userのもつentriesを1つずつ取り出す
          if cu.room_id == u.room_id #current_userと@userのroom_idが同じなら
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    # @following_users = @user.following_users
    # @follower_users = @user.follower_users
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  # def follows
  #   user = User.find(params[:id])
  #   @users = user.following_users
  # end

  # def followers
  #   user = User.find(params[:id])
  #   @users = user.follower_users
  # end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end