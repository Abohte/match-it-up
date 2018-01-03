class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    redirect_to root_path if !current_user.admin
    @users = User.all
  end

  def show
  end


end
