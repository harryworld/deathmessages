class Message < ActiveRecord::Base
  COST_TO_UNLOCK_MESSAGE = 3

  belongs_to :user
  has_many :message_deliveries
  has_many :recipients, through: :message_deliveries, source: :user
end