class UsersController < ApplicationController
  USER_ATTRIBUTES = [:followers_count, :friends_count, :name, :screen_name, :profile_image_url]

  def show
    begin
      @user = @client.user(params[:id])
      response = Hash[USER_ATTRIBUTES.map { |key| [key, @user.send(key)]}]
      if params[:include_rep_score]
        response[:rep_score] = calculate_rep_score(@user, @client.user_timeline(params[:id]))
      end
      render json: response
    rescue Twitter::Error
      render json: { message: 'User not found' }, status: :not_found
    end
  end

  private
  def calculate_rep_score(user, tweets)

  end
end