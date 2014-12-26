class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def check_logged_in
    if session[:username].nil?
      flash[:errors] = ['Please log in first.']
      redirect_to '/'
      return false # stop bubbling
    else
      return true
    end
  end
end
