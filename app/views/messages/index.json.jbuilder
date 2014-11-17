json.array!(@messages) do |message|
  json.extract! message, :id, :title, :content, :photo, :send_date
  json.url message_url(message, format: :json)
end
