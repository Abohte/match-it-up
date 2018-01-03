class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :may_access_index, only: [:index]
  before_action :set_users, only: [:index]

  def index
  end

  def show
  end

  private

  def may_access_index
    redirect_to root_path if !current_user.admin
  end

  def set_users
    @users = User.all if current_user.admin
  end


end
