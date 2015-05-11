class TweetsController < ApplicationController
  # Allow users to filter tweets by number of re-tweets, by dates, with or without picture.
  def index
    query = "from:#{params[:user_id]}"
    if params[:since]
      query += " since:#{params[:since]}"
    end
    if params[:until]
      query += " since:#{params[:until]}"
    end
    if params[:with_picture] == '1'
      query += " filter:images"
    end
    begin
      @tweets = @client.search(query).find_all do |tweet|
        selected = true
        if params[:min_retweets]
          selected = false if tweet.retweet_count < params[:min_retweets].to_i
        end
        selected
      end.map do |tweet|
        {
            :retweet_count => tweet.retweet_count,
            :text => tweet.text,
            :created_at => tweet.created_at,
            :media => tweet.media? ? tweet.media.map{|m| m.uri.to_s} : nil
        }
      end
      render json: @tweets
    rescue Twitter::Error
      render json: { message: 'Something went wrong' }, status: :not_found
    end
  end
end