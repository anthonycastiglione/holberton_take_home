class Book < ApplicationRecord
  has_many :loans
  belongs_to :branch

  def available?
    return true if loans.last.nil?
    !loans.last&.returned_date.nil?
  end

  def checked_out_by_current_user(current_user)
    loans.last.user == current_user && !available?
  end

  def return_book
    loans.last.return
  end
end
