class Message < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :users_messages, foreign_key: :user_id, class_name: :User
  has_and_belongs_to_many :recipients, source: :user, class_name: 'User'
end