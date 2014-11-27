class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def unlockMessage
    # get params from json
    message_id = params[:message_id]

    @message = Message.find_by_id(message_id).message_deliveries.find_by_user_id(current_user.id)

    remaining_credit = current_user.credit - Message::COST_TO_UNLOCK_MESSAGE

    # check if already unlocked and enough credits
    if @message.unlock_date.nil? && (remaining_credit >= 0)
      @message.update(unlock_date:Time.now)
      current_user.update(credit:remaining_credit)
    end
  end

  def index
    if user_signed_in?
      # inbox - all received messages
      all_received_messages = current_user.received_messages.order("created_at DESC")

      # inbox size
      @total_messages = all_received_messages.size

      # check which ones are from dead people
      @received_messages = []
      all_received_messages.map do |message|
        hideNotDeceased(message)
        @received_messages << message
      end

      @sent_messages = Message.all.where(user_id:current_user.id).order("created_at DESC")
    else
      redirect_to messages_path
    end
  end

  def show
    # Hide if not sent from current user
    if @message.user_id != current_user.id
      hideNotDeceased(@message)
    end
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    # get params from json
    recipient_email_list = params[:recipient_email_list]
    title = params[:title]
    content = params[:content]

    #create new message
    @message = Message.new(title:title, content:content, user_id:current_user.id)

    # parse recipient email list into email array
    recipients = recipient_email_list.split(/,\s*/)

    # add new credits depending how many messages sent
    new_credit = current_user.credit + recipients.size
    current_user.update(credit:new_credit)

    # loop through recipients to check if each email exists
    recipients.each do |recipient|
      user = User.find_by_email(recipient)

      # check to see if existing user
      if user.nil?

        #generate random password
        generated_password = Devise.friendly_token.first(8)
        DeathNotesMailer.account_create_notification(recipient,generated_password).deliver

        #create user with this email
        user = User.create(email:recipient, password:generated_password, password_confirmation:generated_password)

      else
        # SEND NEW MESSAGE NOTIFICATION EMAIL TO EXISTING USER

      end

      # insert user into recipients
      @message.recipients << user
    end

    respond_to do |format|
      if @message.save
        format.json { render :show, status: :created, location: @message }
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def editMessage
    # get params from json
    recipient_email_list = params[:recipient_email_list]
    title = params[:title]
    content = params[:content]
    message_id = params[:message_id]

    # parse recipient email list into email array
    recipients = recipient_email_list.split(/,\s*/)
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

    # Hide user details and message content if deceased
    def hideNotDeceased(message)
      if message.user.deceased == false
        if message.message_deliveries.find_by_user_id(current_user.id).unlock_date.nil?
          message.user.firstname = nil
          message.user.lastname = nil
        end
        message.user.email = "???"
        message.title = "???"
        message.content = "???"
      end
    end
end
