class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def authenticate_user!
    return if staff_signed_in?
    super
  end
end
