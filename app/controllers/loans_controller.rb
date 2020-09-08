class LoansController < ApplicationController

  def index
    @loans = Loan.where(user: current_user)
  end
end
