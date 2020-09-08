class Staff::HomeController < ApplicationController
  layout "staff"
  before_action :authenticate_staff!

  def index
  end
end
