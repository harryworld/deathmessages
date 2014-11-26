class User < ActiveRecord::Base
  MINIMUM_RESPONSE_TIME = 1.month

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_many :messages
  has_many :message_deliveries
  has_many :received_messages, through: :message_deliveries, source: :message

  def update_from_omniauth(auth)
    binding.pry
    update(
      facebook_api_key:auth.credentials.token,
      firstname:auth.info.first_name,
      lastname:auth.info.last_name,
      provider:auth.provider,
      uid:auth.uid
    )
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.firstname = auth.info.name   # assuming the user model has a name
      user.firstname = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
