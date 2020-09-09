class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :user

  belongs_to :branch

  scope :current_loans, ->(user) { where(user: user).where(returned_date: nil) }
  scope :previous_loans, ->(user) { where(user: user).where.not(returned_date: nil)}

  def return
    self.returned_date = DateTime.now
    self.save!
  end
end
