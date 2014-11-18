class Message < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :recipients, class_name: 'User'
end