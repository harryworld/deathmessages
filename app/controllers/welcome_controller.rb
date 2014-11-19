class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @sent_messages = Message.all.where(user_id:current_user.id)
      @received_messages = current_user.received_messages
    else
      redirect_to messages_path
    end
  end

  def index2

  end
end
