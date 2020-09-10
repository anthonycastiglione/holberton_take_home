class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :user

  belongs_to :branch

  scope :current_loans, ->(user) { where(user: user).where(returned_date: nil) }
  scope :previous_loans, ->(user) { where(user: user).where.not(returned_date: nil)}
  scope :all_overdue, -> { where("AGE(current_timestamp, due_date) > make_interval(0)").where(returned_date: nil) }

  def return
    self.returned_date = DateTime.now
    self.save!
  end

  def self.all_due_soon_for_user(user)
    current_loans(user).select do |loan|
      loan.due_soon?
    end
  end

  def self.all_overdue_for_user(user)
    current_loans(user).select do |loan|
      loan.overdue?
    end
  end

  def returned?
    !self.returned_date.nil?
  end

  def overdue?
    Time.zone.now - self.due_date > 0 && !returned?
  end

  def due_soon?
    loan_period = ((self.due_date - self.created_at) / 1.day).ceil
    days_left = ((self.due_date - Time.zone.now) / 1.day).ceil

    loan_period - days_left >= loan_period * 0.5 && !overdue?
  end
end
