class SearchesController < ApplicationController
  before_action :authenticate_user!

  # def search
  #   @range = params[:range]

  #   if @range == "User"
  #     @users = User.looks(params[:search], params[:word])
  #   else
  #     @books = Book.looks(params[:search], params[:word])
  #   end
  # end

  def search
    @data = params[:data]
    @word = params[:word]
    @method = params[:method]
    if @data == "User"
      @users = User.look_for(@word, @method)
    else #@data == "Book"
      @books = Book.look_for(@word, @method)
    end
  end

end
