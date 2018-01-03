class PairsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new]
  before_action :validate_access, only: [:new, :create]
  before_action :set_pairs, only: [:index, :show]

  def index

  end

  def new
    @pair = Pair.new
    @pair.matches.new
    @pair.matches.new
    @pair.matches.new
  end

  def create
    @pair = Pair.create(pair_params)
    if @pair.save

      match_params.each do |match|
        puts "user_id: #{match[:user]}"
        if match[:user] != ""
          @pair.matches.create!( user_id: match[:user] )
        end
      end
      redirect_to user_pairs_path(current_user), notice: "Pair created"
    else
      render :new
    end
  end

  private

  def validate_access
    redirect_to root_path if !current_user.admin
  end

  def set_pairs
    @pairs = current_user.valid_pairs
  end

  def match_params
    params[:matches].present? ? params.require(:matches) : []
  end

  def pair_params
    params.require(:pair).permit(:date)
  end

end
