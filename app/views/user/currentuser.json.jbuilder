json.current_user do
  json.firstname current_user.firstname
  json.lastname current_user.lastname
  json.email current_user.email
  json.credit current_user.credit
end