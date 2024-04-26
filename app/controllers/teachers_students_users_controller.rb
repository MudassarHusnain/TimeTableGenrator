class TeachersStudentsUsersController < ApplicationController
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.verified = true
    if @user.save
      redirect_to all_users_path, notice: 'User verification status updated successfully.'
    else
      redirect_to all_users_path, alert: 'Failed to update user verification status.'
    end
  end
end
