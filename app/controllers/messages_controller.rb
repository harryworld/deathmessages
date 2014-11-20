class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def submit
    data = params[:data]
  end

  def index
    if user_signed_in?
      @received_messages = current_user.received_messages
      @sent_messages = Message.all.where(user_id:current_user.id)
    else
      redirect_to messages_path
    end
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    recipient = params[:recipient]
    title = params[:title]
    content = params[:content]
    binding.pry
    @message = Message.new(title:title, content:content, user_id:current_user.id)
    @message.save
  end

  def update
    @message.update(message_params)
  end

  def destroy
    @message.destroy
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:title, :content)
    end
end
