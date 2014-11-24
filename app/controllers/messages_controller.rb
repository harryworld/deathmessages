class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def inbox

  end

  # hide user details and message content if deceased
  def hideNotDeceased(message)
    if message.user.deceased == false
      message.user.firstname=nil
      message.user.lastname=nil
      message.user.email="???"
      message.title="???"
      message.content="???"
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
    hideNotDeceased(@message)
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
    new_gem = current_user.gem + recipients.size
    current_user.update(gem:new_gem)

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
        # format.html { redirect_to @message, notice: 'Lunch was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        # format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
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
