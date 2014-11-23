namespace :user do

  desc "Check each user's online activity to possibly update their 'deceased' status"
  task check_deceased: :environment do
    activity_cutoff_date = Date.today - User::MINIMUM_RESPONSE_TIME

    User.all.each do |user|
      if user.deceased
        next
      end

      if not user.last_sign_in_at.nil? and user.last_sign_in_at >= activity_cutoff_date
        next
      end

      if user.facebook_api_key
        graph = Koala::Facebook::API.new(user.facebook_api_key)

        if Date.parse(graph.get_connections('me', 'statuses').first['updated_time']) >= activity_cutoff_date
          # Most recent status was recent enough
          next
        elsif Date.parse(graph.get_connections('me', 'likes').first['created_time']) >= activity_cutoff_date
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
