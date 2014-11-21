class User < ActiveRecord::Base
  MINIMUM_RESPONSE_TIME = 1.month

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_and_belongs_to_many :received_messages, class_name: 'Message'
end
