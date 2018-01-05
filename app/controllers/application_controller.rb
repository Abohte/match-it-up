require 'ruby/make_pairs'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  Warden::Manager.after_authentication do |user, auth, opts|
    date = Date.today
    if !user.admin && !Pair.where(date: date).any?
     generate(date)
    end
  end
end
