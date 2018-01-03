class PairsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :set_pairs, only: [:index, :show]

  def index

  end

  private

  def set_pairs
    @pairs = current_user.valid_pairs
  end

end
