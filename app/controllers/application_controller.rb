class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session

  before_action :authenticate_user!

  # turn off csrf just for json
  protect_from_forgery with: :null_session
  respond_to :html, :json
end
