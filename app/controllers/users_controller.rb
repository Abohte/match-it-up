class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :validate_access, only: [:index]
  before_action :set_users, only: [:index]

  def index
  end

  def show
  end

  def toggle_admin
    @user = User.find(params[:user_id])
    @user.toggle!(:admin)
    redirect_to users_path
  end


  private

  def validate_access
    redirect_to root_path if !current_user.admin
  end

  def set_users
    @users = User.all if current_user.admin
  end
end
