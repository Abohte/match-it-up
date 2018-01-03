class PairsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  # before_action :set_user, only: [:index, :show]
  before_action :set_pairs, only: [:index, :show]

  def index

  end



  private

  # def set_user
  #   @user = current_user
  # end

  def set_pairs
    if current_user.admin
      @pairs = Pair.all
    else
      @pairs = current_user.pairs
    end
  end
end
