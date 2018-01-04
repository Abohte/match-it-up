class PairingProgress < ActiveRecord::Base
  validates on: :create, if: :check_record?


  def check_record?
    if PairingProgress.all.count > 1
      errors[:base] << "You can only have one PairingProgress"
      return false
    else
      return true
    end
  end


end
