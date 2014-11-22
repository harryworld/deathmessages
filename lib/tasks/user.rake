namespace :user do

  desc "Check each user's online activity to possibly update their 'deceased' status"
  task check_deceased: :environment do
    User.each do |user|
      if user.deceased
        next
      end

      if user.last_sign_in_at <= User.MINIMUM_RESPONSE_TIME
        next
      end

      if user.facebook_api_key
        graph = Koala::Facebook::API.new(user.facebook_api_key)

        if Date.today - Date.parse(graph.get_connections('me', 'statuses').first['updated_time']) <= User.MINIMUM_RESPONSE_TIME
          # Most recent status was recent enough
          next
        elsif Date.today - Date.parse(graph.get_connections('me', 'likes').first['created_time']) <= User.MINIMUM_RESPONSE_TIME
          # Most recent like was recent enough
          next
        end
      end

      # If we reached here, user must be dead
      user.deceased = true
      # TODO: send off all the emails!
    end
  end

end
