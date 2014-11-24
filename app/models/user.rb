class User < ActiveRecord::Base
  MINIMUM_RESPONSE_TIME = 1.month

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :message_deliveries
  has_many :received_messages, through: :message_deliveries, source: :message
end
