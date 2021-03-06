# json.array!(@received_messages) do |received_message|
#   json.extract! received_message, :id, :title, :content, :date, :user
#   json.url message_url(received_message, format: :json)
# end

# json.array!(@sent_messages) do |sent_message|
#   json.extract! sent_message, :id, :title, :content, :date, :user
#   json.url message_url(sent_message, format: :json)
# end

# json.received_messages @received_messages

# json.sent_messages @sent_messages

json.received_messages (@received_messages) do |received_message|
  json.extract! received_message, :id, :title, :content, :created_at
#  json.url  message_url(received_message, format: :json)
  json.firstname received_message.user.firstname
  json.lastname received_message.user.lastname
  json.email received_message.user.email
end

json.sent_messages (@sent_messages) do |sent_message|
  json.extract! sent_message, :id, :title, :content, :created_at
  # json.url message_url(sent_message, format: :json)
  json.recipients (sent_message.recipients) do |recipient|
    json.extract! recipient, :firstname, :lastname, :email
  end
end