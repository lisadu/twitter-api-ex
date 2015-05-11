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
    begin
      @tweets = @client.search(query)
      render json: @tweets
    rescue Twitter::Error
      render json: { message: 'User not found' }, status: :not_found
    end
  end
end