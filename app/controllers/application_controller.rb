class ApplicationController < ActionController::Base
  require "application_controller"

  protect_from_forgery
  
  private
  def check_session
    if session[:auth_id]
      @user = User.find(session[:auth_id])
      redirect_to "/login?error=p_inv" if (not @user.active) or (request.fullpath.include? "/admin" and (not @user.is_admin?))
    else
      redirect_to "/login?error=s_und"
    end
  end
end
