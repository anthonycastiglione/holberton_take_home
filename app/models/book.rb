class Book < ApplicationRecord
  has_many :loans

  def available?
    return true if loans.last.nil?
    !!loans.last&.returned
  end

  def checked_out_by_current_user(current_user)
    loans.last.user == current_user
  end
end
