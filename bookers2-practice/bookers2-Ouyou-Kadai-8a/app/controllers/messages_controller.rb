class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      # @message = Message.create(params.require(:message).permit(:user_id, :room_id, :content).merge(user_id: current_user.id))
      @message = Message.new(message_params)
      @message.user_id = current_user.id
      @message.save
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
    render :validater unless @message.save
    # redirect_back(fallback_location: root_path)
  end

  private

    def message_params
      params.require(:message).permit(:user_id, :room_id, :content)
    end

end
