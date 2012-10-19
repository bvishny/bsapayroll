class ApplicationController < ActionController::Base
  require "application_controller"

  protect_from_forgery
  
  private
  def check_session
    if session[:auth_id]
      @user = User.find(session[:auth_id])
      redirect_to "/login?error=p_inv" if (not @user.active) or (request.fullpath.include? "/admin" and (not @user.is_admin?))
    elsif (not session[:auth_id]) and params[:auth_key]
      @user = User.find_by_auth_key(params[:auth_key])
      session[:auth_id] = @user.id unless @user.blank?
      redirect_to request.fullpath.gsub("&auth_key=#{params[:auth_key]}", "").gsub("?auth_key=#{params[:auth_key]}", "")
    else
      redirect_to "/login?error=s_und"
    end
  end
end
