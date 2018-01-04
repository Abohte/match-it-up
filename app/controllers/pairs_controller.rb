require 'ruby/make_pairs'
require 'date'

class PairsController < ApplicationController

  before_action :authenticate_user!, only: [:index, :show, :new]
  before_action :validate_access, only: [:new, :create, :delete, :delete_all_pairs]
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

  def generate_pairs
    date = convert_date_params(date_params)
    # in make_pairs.rb
    generate(date)
    redirect_to user_pairs_path(current_user), notice: "New pairs generated"
  end

  def delete

  end

  def delete_on_date
    date = convert_date_params(date_params)
    pairs_to_delete = Pair.where(date: date)

    if pairs_to_delete.any? && pairs_to_delete.destroy_all

      redirect_to user_pairs_path(current_user), notice: "Pairs deleted for #{date}"
    else
      redirect_to user_pairs_path(current_user), alert: "Nothing deleted"
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

  def convert_date_params(date_params)
    Date.new(date_params["date(1i)"].to_i, date_params["date(2i)"].to_i, date_params["date(3i)"].to_i)
  end

  def date_params
    params.require(:date).permit(:utf8, :authenticity_token, :date, :commit)
  end

end
