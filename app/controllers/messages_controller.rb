class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      @received_messages = current_user.received_messages.order("created_at DESC")
      @sent_messages = Message.all.where(user_id:current_user.id).order("created_at DESC")
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
    # get params from json
    recipient_email_list = params[:recipient_email_list]
    title = params[:title]
    content = params[:content]

    #create new message
    @message = Message.new(title:title, content:content, user_id:current_user.id)

    # parse recipient email list into email array
    recipients = recipient_email_list.split(/,\s*/)

    recipients.each do |recipient|
      user = User.find_by_email(recipient)

      # check to see if existing user
      if user.nil?

        #generate random password
        generated_password = Devise.friendly_token.first(8)
        # ^^^^^^^^^^^^^^^^^^^^^^^^^^^
        # THIS NEEDS TO BE SENT TO USER THRU EMAIL

        #create user with this email
        user = User.create(email:recipient, password:generated_password, password_confirmation:generated_password)
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
