class Staff::HomeController < ApplicationController
  layout "staff"
  before_action :authenticate_staff!

  def index
    @all_overdue = Loan.all_overdue
  end
end
