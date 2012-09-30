class UserController < ApplicationController
  before_filter :check_session
  
  def index
    @title = "Enter Payroll"
    (@timesheet = @user.timesheet).update_attributes(params[:timesheet]) if request.post?
  end

  def edit
    @title = "Change Password"
    @user.update_attributes(params[:user_profile]) if params[:user_profile]
  end
end
