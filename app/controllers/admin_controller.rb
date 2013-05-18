class AdminController < ApplicationController
  layout 'application', :except => [:print_timesheet]
  before_filter :check_session
  
  def index
  end
  
  # Reminder Emails
  def send_reminders
    submitted = Week.current.collect { |week| week.user_id }
    User.worker.each { |user| UserMailer.send_reminder_email(user).deliver }
    render :text => "OK"
  end
  
  # Print Timesheets
  def timesheets
    @weeks = Week.current((params[:weeks_ago] ||= 0).to_i).select { |week| week.user and week.user.report_payroll }.sort { |a, b| a.user.name.split(" ")[-1] <=> b.user.name.split(" ")[-1] }
    respond_to do |format|
      format.html { render layout: false }
      format.xlsx {
        render xlsx: "timesheets", disposition: "attachment", filename: "payroll_#{Time.now.strftime("%m%d")}.xlsx"
      }
    end
  end
  
  def timesheet
    @week = Week.find(params[:id])
    render :layout => false
  end
  
  # User Management
  def delete_user
    @user = User.find_by_name(params[:id])
    @user.update_attribute(:active, 0)
    render :text => "OK"
  end

  def add_user
    if request.post?
      @user = User.create(params[:user])
      render :text => "OK"
    end
  end
end
