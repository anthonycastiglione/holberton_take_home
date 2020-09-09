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

  def self.due_soon(user)
    outstanding = Loan.where(user: user).where(returned_date: nil)

    outstanding.select do |loan|
      loan_period = ((loan.due_date - loan.created_at) / 1.day).ceil
      days_left = ((loan.due_date - Time.zone.now) / 1.day).ceil

      loan_period - days_left >= loan_period * 0.5
    end
  end
end
