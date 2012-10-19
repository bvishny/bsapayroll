class LoginController < ApplicationController
  def index
    if request.post?
      user = User.authenticate(params[:email].downcase, params[:password])
      session[:auth_id] = user.id if user
      redirect_to ((user.report_payroll == true) ? "/user/" : "/admin") unless session[:auth_id].nil?
    end
  end

  def reset
    if request.post?
    elsif params[:id]
      session[:auth_id] = (user = User.find_by_auth_key(params[:id])).try(:id)
      (session[:auth_id].nil?) ? (render :text => "Invalid token") : (redirect_to ((user.report_payroll == true) ? "/user/#{(params[:page]) ? "" : "edit"}" : "/admin"))
    end
  end
  
  def logout
    reset_session
    redirect_to "/login?logged_out=1"
  end
end
