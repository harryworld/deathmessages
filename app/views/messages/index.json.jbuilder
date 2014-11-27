json.received_messages (@received_messages) do |received_message|
  json.extract! received_message, :id, :title, :content, :created_at
  json.firstname received_message.user.firstname
  json.lastname received_message.user.lastname
  json.email received_message.user.email
end

json.sent_messages (@sent_messages) do |sent_message|
  json.extract! sent_message, :id, :title, :content, :created_at
  json.recipients (sent_message.recipients) do |recipient|
    json.extract! recipient, :firstname, :lastname, :email
  end
end