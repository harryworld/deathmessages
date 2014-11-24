class Message < ActiveRecord::Base
  belongs_to :user
  has_many :message_deliveries
  has_many :recipients, through: :message_deliveries, source: :user
end