class ApplicationController < ActionController::Base

  protect_from_forgery wit: :exception
  before_action :authenticate_user!
end
