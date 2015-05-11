class UsersController < ApplicationController

  def show
    begin
      @user = @client.user(params[:id])
      render json: @user
    rescue Twitter::Error
      render json: { message: 'User not found' }, status: :not_found
    end
  end
end