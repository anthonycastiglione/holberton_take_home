class Book < ApplicationRecord
  has_many :loans
  belongs_to :branch

  has_and_belongs_to_many :genres

  def self.genre_search(search_term, current_user)
    joins(:genres).where("genres.name ilike ?", "%#{search_term}%").where(branch: current_user.branch)
  end

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
