class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new

    @user = @book.user
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

    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end

  end

  def index
    # @books = Book.all
    @book = Book.new
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    # @books = Book.includes(:favorited_users).
    #   sort_by {|x|
    #     x.favorited_users.includes(:favorites).where(created_at: from...to).size
    #   }.reverse

    @books = Book.all.sort {|a,b|
      b.favorites.where(created_at: from...to).size <=>
      a.favorites.where(created_at: from...to).size
    }

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
