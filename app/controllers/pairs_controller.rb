class PairsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new]
  before_action :set_pairs, only: [:index, :show]

  def index

  end

  def new
    @pair = Pair.new
    @match1 = @pair.matches.new
    @match2 = @pair.matches.new
  end

  def create

  end

  private

  def set_pairs
    @pairs = current_user.valid_pairs
  end

  def pair_params
    params.require(:pair, :match).permit(:date, :user1, :user2, :user3)
  end

end
