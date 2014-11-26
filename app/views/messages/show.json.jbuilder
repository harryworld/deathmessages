json.extract! @message, :id, :title, :content, :created_at
json.sender_firstname @message.user.firstname
json.sender_lastname @message.user.lastname
json.sender_email @message.user.email